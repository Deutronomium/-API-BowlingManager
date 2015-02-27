class FinePayment < ActiveRecord::Base

  #Association
  belongs_to :fine
  belongs_to :participation

  def self.get_by_user_and_event(user_id, event_id)
    participation = Participation.where(user_id: user_id, event_id: event_id)
    fine_payments = FinePayment.where(participation: participation)
  end
end