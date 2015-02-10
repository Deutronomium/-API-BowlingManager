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

  def drink_params
    params.require(:drink).permit(:name, :price, :club_id)
  end
end