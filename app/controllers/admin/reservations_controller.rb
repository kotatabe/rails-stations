class Admin::ReservationsController < ApplicationController
  def index
    @reservations = Reservation.all
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      redirect_to admin_reservations_path,
                      flash: {key: "予約の新規作成に成功しました"}
    else
      flash.now[:danger] = "予約の新規作成に失敗しました"
      render 'new', status: 400
    end
  end

  def edit
    @reservation = Reservation.find(params[:id])
  end

  def update
    @reservation = Reservation.find(params[:id])
    if @reservation.update(reservation_params)
      redirect_to admin_reservations_path,
                                flash: {success: "予約を更新しました"}
    else
      flash.now[:danger] = "予約の更新に失敗しました"
      render 'edit', status: 400
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    if @reservation.destroy
      redirect_to admin_reservations_path, flash: {success: "データの削除に成功しました"}
    else
      flash.now[:danger] = "データの削除に失敗しました"
      render 'index'
    end
  end

  private
    def reservation_params
      params.require(:reservation).permit(:schedule_id, :sheet_id, :date, :name, :email)
    end
end
