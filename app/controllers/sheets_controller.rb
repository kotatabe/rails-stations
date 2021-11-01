class SheetsController < ApplicationController
  def index
    @sheets = Sheet.all
    @movie_id = id_params[:movie_id]
    @schedule_id = id_params[:schedule_id]
    @date = date_params[:date]
  end

  private
    def id_params
      params.permit(:movie_id, :schedule_id)
    end

    def date_params
      params.permit(:date)
    end
end
