class MoviesController < ApplicationController

  def index
    @movies = Movie.search(search_params[:keyword],
                           search_params[:is_showing])
  end

  def show
    @movie = Movie.find(params[:id])
    @schedules = @movie.schedules
    if params[:date]
      @date = params[:date]
    end
  end

  private
    def search_params
      params.permit(:keyword, :is_showing)
    end

end
