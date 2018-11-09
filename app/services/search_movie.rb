require 'dotenv/load'
require 'themoviedb'
require 'nokogiri'
require 'open-uri'


class SearchMovie

	attr_accessor :request, :search, :result_array

	def initialize(request)
		@request = request
		Tmdb::Api.key(ENV['APIKey'])
		@search = Tmdb::Search.new
		@result_array = Array.new
	end
	
	def movie_search		
		@search.resource('movie')
		@search.query(@request)
		return @search.fetch
	end

	def array_without_director
		movie_search.each_with_index { |movie, i|
			if i < 20
				@result_array << {
					:id => movie['id'],
					:title => movie['title'],
					:poster => "https://image.tmdb.org/t/p/w1280#{movie['poster_path']}",
					:release => movie['release_date'],
					:url => "https://www.themoviedb.org/movie/#{movie['id']}"
				}
			else
				return @result_array
			end
		}
		return @result_array
	end

	def complete_array
		array_without_director.each { |movie|
			page = Nokogiri::HTML(open(movie[:url]))
			movie[:director] = page.css("div.custom_bg ol.people li[1] p[1]").text
		}
	end

	def perform
		complete_array
		return @result_array
	end
end