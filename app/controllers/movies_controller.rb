class MoviesController < ApplicationController

  def search
  	@results = SearchMovie.new(params[:movie_title]).perform

  end
end
