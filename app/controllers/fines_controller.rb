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

  def fine_params
    params.require(:fine).permit(:name, :amount, :club_id)
  end
end