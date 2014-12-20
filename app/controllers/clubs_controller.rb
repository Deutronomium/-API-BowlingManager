class ClubsController < ApplicationController
  def index
    clubs = Club.all
    if clubName = params[:name]
      clubs = clubs.where(name: clubName)
    end
    render json: clubs, status: 200
  end

  def getMembers
    club_name = params[:club][:name]
    
    club = Club.find_by_name(club_name)
    
    if !club.nil?
      users = club.users
      render json: users, status: 200
    else
      render json: { error: { info: 'Could not find any members of this club!' } }, status: 422
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
      error = { error: { club: 'club not found' } }
      render json: error.to_json, status: 422
    end
  end

  def delete_by_name
      club_name = params[:club][:name]
      club = Club.find_by_name(club_name)
      print Club.count

      club.destroy!
      render nothing: true, status: 204
    rescue ActiveRecord::RecordNotFound
      error = { error: { club: 'club not found' } }
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
    if !club.attribute_valid?('name')
      render json: {
                 name: 'This clubname already exists. Please choose another one!'
             }, status: 422
    else
      render json: club, status: 200
    end
  end

  def addMembers
    add_members = params[:add_members]
    club = Club.find_by_name(add_members[:club])
    members = add_members[:members]
    members.each do |member|
      user = User.find_by_phone_number(member)
      user.update_attribute(:club_id, club.id)
    end

    render nothing: true, status: 200
  end

  def club_params
    params.require(:club).permit(:name)
  end

  def add_members_params
    params.require(:add_members).permit(:club, :members => [])
  end
end