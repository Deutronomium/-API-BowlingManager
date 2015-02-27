class FinePaymentsController < ApplicationController

  def create
    user_id = fine_payment_params[:user_id]
    event_id = fine_payment_params[:event_id]
    fine_id = fine_payment_params[:fine_id]
    participation = Participation.where(user_id: user_id, event_id: event_id).first
    create_params = { participation_id: participation.id, fine_id: fine_id }
    fine_payment = FinePayment.new(create_params)
    if fine_payment.save
      render json: fine_payment, status: 201
    else
      error = {error: {message: 'Could not create Fine Payment!'}}
      render json: error, status: 422
    end
  end

  def get_by_user_and_event
    user_id = get_by_user_and_event_params[:user_id]
    event_id = get_by_user_and_event_params[:event_id]
    fine_payments = FinePayment.get_by_user_and_event(user_id, event_id)
    render json: fine_payments, status: 200
  end

  def fine_payment_params
    params.require(:fine_payment).permit(:user_id, :event_id, :fine_id)
  end

  def get_by_user_and_event_params
    params.require(:fine_payment).permit(:user_id, :event_id)
  end
end