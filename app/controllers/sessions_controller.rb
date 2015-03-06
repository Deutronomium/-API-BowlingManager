class SessionsController < ApplicationController

  def create
    user = User.find_by_email(session_params[:email].downcase)
    if user && user.authenticate(session_params[:password])
      render json: user, status: 200
    elsif user
      error = {error: {message: 'Wrong password'}}
      render json: error, status: 461
    else
      error = {error: {message: 'Wrong email'}}
      render json: error, status: 460
    end
  end

  def session_params
    params.require(:session).permit(:email, :password)
  end
end