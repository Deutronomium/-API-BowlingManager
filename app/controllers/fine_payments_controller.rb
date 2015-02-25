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

  def fine_payment_params
    params.require(:fine_payment).permit(:user_id, :event_id, :fine_id)
  end
end