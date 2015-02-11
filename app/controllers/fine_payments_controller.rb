class FinePaymentsController < ApplicationController

  def create
    fine_payment = FinePayment.new(fine_payment_params)
    if fine_payment.save
      render json: fine_payment, status: 201
    else
      error = {error: {message: 'Could not create Fine Payment!'}}
      render json: error, status: 422
    end
  end

  def fine_payment_params
    params.require(:fine_payment).permit(:participation_id, :fine_id)
  end
end