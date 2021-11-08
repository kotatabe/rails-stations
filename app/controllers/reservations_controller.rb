class ReservationsController < ApplicationController
	before_action :login_required

  def new
    @reservation = Reservation.new
    @user = current_user
    @schedule = Schedule.find_by(id: id_params[:schedule_id])
    @movie = Movie.find_by(id: id_params[:movie_id])
    @sheet = Sheet.find_by(id: id_params[:sheet_id])
    @date = date_params[:date]
    if (@date.nil?) || (@sheet.nil?) || (@movie.nil?)
      redirect_to movie_path(id_params[:movie_id])
    else
      render status: 200
    end
  end

  def create
    @reservation = Reservation.new(reservasion_params)
    if @reservation.save
      redirect_to movie_path(id_params[:movie_id]), 
                              flash: {info: "予約に成功しました"}
    else
      redirect_to movie_schedule_sheets_path(id_params[:movie_id], 
                                            id_params[:schedule_id], 
                                            date: reservasion_params[:date]), 
                                            flash: {danger: "その座席はすでに予約済みです"}
    end
  end

  private
    def id_params
      params.permit(:movie_id, :schedule_id, :sheet_id)
    end

    def reservasion_params
      params.require(:reservation).permit(:user_id, :date, :schedule_id, :sheet_id, :name, :email)
    end

    def date_params
      params.permit(:date)
    end

end
