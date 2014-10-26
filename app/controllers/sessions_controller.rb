class SessionsController < ApplicationController

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      render json: {
        info: 'logged in'
      }, status: 201
    else
      render json: {
          error: 'login failed'
      }, status: 401
    end
  end
end