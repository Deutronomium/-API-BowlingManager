class FinesController < ApplicationController

  def create
    fine = Fine.new(fine_params)
    if fine.save
      render json: fine, status: 201
    else
      error = {error: {message: 'Could not create fine!'}}
      render json: error, status: 422
    end
  end

  def get_by_club
    club_id = get_by_club_params[:club_id]

    fines = Fine.where(:club_id => club_id)

    render json: fines, status: 200
  end

  def fine_params
    params.require(:fine).permit(:name, :amount, :club_id)
  end

  def get_by_club_params
    params.require(:fine).permit(:club_id)
  end
end