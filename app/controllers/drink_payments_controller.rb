class DrinkPaymentsController < ApplicationController

  def create
    drink_payment = DrinkPayment.new(drink_payment_params)
    if drink_payment.save
      render json: drink_payment, status: 201
    else
      error = {error: {message: 'Could not create Drink Payment!'}}
      render json: error, status: 422
    end
  end

  def drink_payment_params
    params.require(:drink_payment).permit(:participation_id, :drink_id)
  end
end