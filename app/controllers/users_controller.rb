class UsersController < ApplicationController
  def index
    users = User.all
    if userName = params[:userName]
        users = users.where(userName: userName)
    end
    render json: users, status: 200
  end

  def user_club
    userParams = params[:user]
    userName = userParams[:userName]
    user = User.find_by_userName(userName)
    print user.id
    club = Club.find(user.club_id)
    print club.id
    render json: club, status: 200
  end

  def delete_by_name
    user_name = params[:user][:userName]
    user = User.find_by_userName(user_name)
    user.destroy
    render nothing: true, status: 204
  rescue ActiveRecord::RecordNotFound
    error = { error: { info: 'User not found' } } 
    render json error.to_json, status: 422
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: 201, location: user
    else
      render json: user.errors, status: 422
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
    if !user.email_and_user_name_valid?
      print 'test'
      render json: {
                 error: 'Username and email already exist. Please choose a different name and email!'
             }, status: 422
    elsif !user.attribute_valid?('userName')
      render json: {
                 userName: 'This username already exists. Please choose another one!'
             }, status: 422
    elsif !user.attribute_valid?('email')
      render json: {
                 email: 'This email already exists. Please choose another one!'
             }, status: 422
    else
      render json: user, status: 200
    end
  end

  def user_params
    params.require(:user).permit(:userName, :firstName, :lastName, :email, :club_id, :street, :city, :password,
                                 :password_confirmation, :phone_number)
  end
end