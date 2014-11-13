class SessionsController < ApplicationController

  def create
    user = User.find_by_email(session_params[:email])
    if user && user.authenticate(session_params[:password])
      render json: {
        response: 'login successful'
      }, status: 201
    else
      render json: {
          response: 'login failed'
      }, status: 401
    end
  end

  def session_params
    params.require(:session).permit(:email, :password)
  end
end