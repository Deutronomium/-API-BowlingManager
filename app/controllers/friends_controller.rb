class FriendsController < ApplicationController
  def registeredFriends
    friend =  params[:friends]
    phone_numbers = friend[:phone_numbers]
    matching_users = friend_phone_numbers(phone_numbers)

    render json: matching_users, status: 200
  end

  def friend_params
    params.require(:friends).permit(:phone_numbers => [])
  end

  def friend_phone_numbers(phone_numbers)
    @matching_users = []
    phone_numbers.each do |phone_number|
      user = User.find_by_phone_number(phone_number)
      if user
        @matching_users << user
      end
    end

    @matching_users
  end
end