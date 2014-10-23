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

  def update
    club = Club.find(params[:id])
    if club.update(club_params)
      render json: club, status: 200
    else
      render json: club.errors, status: 422
    end
  end

  def club_params
    params.require(:club).permit(:name)
  end
end