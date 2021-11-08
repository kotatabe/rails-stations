class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: session_params[:email])

    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_back_or user
    else
      flash.now[:danger] = '無効なメールアドレス/パスワードです'
      render 'new'
    end
  end

  def destroy
    reset_session
    redirect_to movies_path, flash: {success: 'ログアウトしました'}
  end

  private
    def session_params
      params.permit(:email, :password)
    end
end
