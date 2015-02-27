class FinePayment < ActiveRecord::Base

  #Association
  belongs_to :fine
  belongs_to :participation

  def self.get_by_user_and_event(user_id, event_id)
    participation = Participation.where(user_id: user_id, event_id: event_id)
    fine_payments = FinePayment.where(participation: participation)
  end

  def self.total_by_user_and_event(user_id, event_id)
    fine_payments = get_by_user_and_event(user_id, event_id)
    total_amount = 0
    fine_payments.each do |fine_payment|
      fine = Fine.find(fine_payment.fine_id)
      total_amount += fine.amount
    end

    return total_amount
  end
end