class UsersController < ApplicationController
  def index
    users = User.all
    if userName = params[:userName]
        users = users.where(userName: userName)
    end
    render json: users, status: 200
  end
end