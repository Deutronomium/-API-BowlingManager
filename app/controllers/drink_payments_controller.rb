class DrinkPaymentsController < ApplicationController

  def create
    user_id = drink_payment_params[:user_id]
    event_id = drink_payment_params[:event_id]
    participation = Participation.where(user_id: user_id, event_id: event_id).first
    create_params = { participation_id: participation.id, drink_id: drink_payment_params[:drink_id] }
    drink_payment = DrinkPayment.new(create_params)
    if drink_payment.save
      render json: drink_payment, status: 201
    else
      error = {error: {message: 'Could not create Drink Payment!'}}
      render json: error, status: 422
    end
  end

  def get_by_user_and_event
    user_id = get_by_user_and_event_params[:user_id]
    event_id = get_by_user_and_event_params[:event_id]

    drink_payments = DrinkPayment.get_drinks_by_user_and_event(user_id, event_id)
    render json: drink_payments, status: 200
  end

  def total_by_user_and_event
    user_id = get_by_user_and_event_params[:user_id]
    event_id = get_by_user_and_event_params[:event_id]

    total_price = DrinkPayment.total_amount_by_user_and_event(user_id, event_id)
    total_price_json = {total_price: total_price}
    render json: total_price_json, status: 200
  end



  def drink_payment_params
    params.require(:drink_payment).permit(:user_id, :event_id, :drink_id)
  end

  def get_by_user_and_event_params
    params.require(:drink_payment).permit(:user_id, :event_id)
  end

end