class ClubsController < ApplicationController
  def index
    render json: Club.all, status: 200
  end

  def create
    club = Club.new(club_params)
    if club.save
      render json: club, status: 201, location: club
    else
      render json: club.errors, status: 422
    end
  end

  def club_params
    params.require(:club).permit(:name)
  end
end