class SessionsController < ApplicationController

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      render json: {
        response: 'login successful'
      }, status: 201
    else
      render json: {
          response: 'login failed'
      }, status: 401
    end
  end
end