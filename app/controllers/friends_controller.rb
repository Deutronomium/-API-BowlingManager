class FriendsController < ApplicationController
  def getRegisteredFriends
    friend =  params[:friends]
    phone_numbers = friend[:phone_numbers]
    matching_users = friend_phone_numbers(phone_numbers)

    render json: matching_users, status: 200
  end

  def friend_params
    params.require(:friends).permit(:phone_numbers => [])
  end

  def remove_friend_params
    params.require(:friends).permit(:user_name, :club_name)
  end

  def removeFriendFromClub
    friends = params[:friends]
    user_name = friends[:user_name]
    club_name = friends[:club_name]

    club = Club.find_by_name(club_name)
    user = User.find_by_user_name(user_name)

    if user 
      club.users.delete(user)
      render json: { success: { message: 'Friend successfully removed from club!'} }, status: 200
    else
      render json: { error: { message: 'Could not find the member!' } }, status: 422
    end
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