class ClubsController < ApplicationController
  def index
    clubs = Club.all
    if clubName = params[:name]
      clubs = clubs.where(name: clubName)
    end
    render json: clubs, status: 200
  end

  def get_members
    club_name = params[:club][:name]

    club = Club.find_by_name(club_name)

    if club.nil?
      render json: {error: {info: 'Could not find any members of this club!'}}, status: 422
    else
      users = club.users
      render json: users, status: 200
    end
  end

  def create
    club = Club.new(club_params)
    if club.save
      render json: club, status: 201, location: club
    else
      render json: club.errors, status: 422
    end
  end

  def destroy
    begin
      club = Club.find(params[:id])

      club.destroy!
      render nothing: true, status: 204
    rescue ActiveRecord::RecordNotFound
      error = {error: {club: 'club not found'}}
      render json: error.to_json, status: 422
    end
  end

  def delete_by_name
    user_name = params[:club][:name]
    user = User.find_by_user_name(user_name)

    user.destroy!
    render nothing: true, status: 204
  rescue ActiveRecord::RecordNotFound
    error = {error: {club: 'club not found'}}
    render json: error.to_json, status: 422
  end

  def update
    club = Club.find(params[:id])
    if club.update(club_params)
      render json: club, status: 200
    else
      render json: club.errors, status: 422
    end
  end

  def check
    club = Club.new(club_params)
    if club.attribute_valid?('name')
      render json: club, status: 200
    else
      render json: {
                   name: 'This clubname already exists. Please choose another one!'
               }, status: 400
    end
  end

  def add_members
    club_params = params[:club]

    club = Club.find(club_params[:id])
    members = club_params[:members]

    if club.nil?
      error = {error: {message: 'Could not find given club!'}}
      render json: error, status: 422
    else
      if !members.nil?
        members.each do |member|
          user = User.find_by_phone_number(member)
          user.update_attribute(:club_id, club.id)
        end
      end
      render nothing: true, status: 200
    end
  rescue ActiveRecord::RecordNotFound
    error = {error: {message: 'Club does not exist!'}}
    render json: error, status: 422
  end


  def club_params
    params.require(:club).permit(:name)
  end

  def add_members_params
    params.require(:club).permit(:id, :members => [])
  end
end