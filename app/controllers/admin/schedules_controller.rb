class Admin::SchedulesController < ApplicationController
  def index
    @schedules = Schedule.all
  end

  def new
    @schedule = Schedule.new
  end

  def create
    @schedule = Schedule.new(schedule_params)
		if @schedule.save
			redirect_to admin_schedules_path
		else
      flash.now[:danger] = "新規データ登録に失敗しました"
			render 'new'
		end
  end

  def edit
    @schedule = Schedule.find(params[:id])
  end

  def update
    @schedule = Schedule.find(params[:id])
    if @schedule.update(schedule_params)
      redirect_to admin_schedules_path
    else
      flash.now[:danger] = "データの更新に失敗しました"
      render 'edit'
    end
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    if @schedule.destroy
      redirect_to admin_schedules_path, notice: "データの削除に成功しました"
    else
      flash.now[:danger] = "データの削除に失敗しました"
      render 'index'
    end
  end

  private
    def schedule_params
      params.require(:schedule).permit(:movie_id, :start_time, :end_time)
    end
end
