class MoviesController < ApplicationController

	def index
		if params[:movie_request] != nil
			@movie_request = params[:movie_request]
			@results = SearchMovie.new(params[:movie_request]).perform
		else
			@movie_request = nil
			@results = nil
		end
	end

	def update
		redirect_to movie_search_path(params[:movie][:request])
	end

end
