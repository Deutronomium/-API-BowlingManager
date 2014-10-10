class UsersController < ApplicationController
  def index
    users = User.all
    if userName = params[:userName]
        users = users.where(userName: userName)
    end
    render json: users, status: 200
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: 201, location: user
    else
      render json: user.errors, status: 422
    end
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      render json: user, status: 200
    else
      render json: user.errors, status: 422
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy!
    render nothing: true, status: 204
  end

  def user_params
    params.require(:user).permit(:userName, :firstName, :lastName, :mail, :club_id, :street, :city)
  end
end