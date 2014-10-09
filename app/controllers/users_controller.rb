class UsersController < ApplicationController
  def index
    users = User.all
    if userName = params[:userName]
        users = users.where(userName: userName)
    end
    render json: users, status: 200
  end

  def create
    user = User.new(book_params)
    if user.save
      render json: user, status: 201, location: user
    else
      render json: user.errors, status: 422
    end
  end

  def book_params
    params.require(:user).permit(:userName, :firstName, :lastName, :mail, :club_id, :street, :city)
  end

  def destroy
    user = User.find(params[:id])
    user.destroy!
    render nothing: true, status: 204
  end
end