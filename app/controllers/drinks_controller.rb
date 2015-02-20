class DrinksController < ApplicationController

  def create
    drink = Drink.new(drink_params)
    if drink.save
      render json: drink, status: 201, location: drink
    else
      error = {error: {message: 'Could not create drink!'}}
      render json: error, status: 422
    end
  end

  def get_by_club
    club_id = get_by_club_params[:club_id]

    drinks = Drink.where(:club_id => club_id)

    render json: drinks, status: 200
  end

  def update
    drink = Drink.find(params[:id])
    if drink.update(drink_params)
      render json: drink, status: 200
    else
      render json: drink.errors, status: 422
    end
  end

  def drink_params
    params.require(:drink).permit(:name, :price, :club_id)
  end

  def get_by_club_params
    params.require(:drink).permit(:club_id)
  end
end