class UsersController < ApplicationController
  def index
    users = User.all
    if user_name = params[:user_name]
        users = users.where(user_name: user_name)
    end
    render json: users, status: 200
  end

  def user_club
    user_params = params[:user]
    user_name = user_params[:user_name]
    user = User.find_by_user_name(user_name)
    if user.club_id?
      club = Club.find(user.club_id)
      render json: club, status: 200
    else
      error = { error: {
        message: 'User has no club yet.'
      } }
      render json: error, status: 450
    end
  rescue ActiveRecord::RecordNotFound
    error = { error: {
        message: 'Club does not exist'
    } }
    render json: error, status: 422
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: 201, location: user
    else
      error = { error: { message: 'Could not create user'} }
      render json: error, status: 422
    end
  end

  def destroy
    begin
      user = User.find(params[:id])
      user.destroy!
      render nothing: true, status: 204
    rescue ActiveRecord::RecordNotFound
      error = { error: {
          status: 'User not found'
      } }
      render json: error.to_json, status: 422
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

  def check
    user = User.new(user_params)
    if !user.attribute_valid?('user_name') && user.attribute_valid?('email')
      error = { error: { message: UserErrors::USER } }
      render json: error, status: 451
    elsif !user.attribute_valid?('email') && user.attribute_valid?('user_name')
      error = { error: { message: UserErrors::EMAIL} }
      render json: error, status: 452
    elsif !user.email_and_user_name_valid?
      error = { error: { message:  UserErrors::USER_AND_EMAIL} }
      render json: error, status: 450
    else
      render json: user, status: 200
    end
  end

  def user_params
    params.require(:user).permit(:user_name, :first_name, :last_name, :email, :club_id, :street, :city, :password,
                                 :password_confirmation, :phone_number)
  end
end