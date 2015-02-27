class DrinkPayment < ActiveRecord::Base

  #Association
  belongs_to :drink
  belongs_to :participation

  def self.get_drink_by_user_and_event(user_id, event_id)
    participation = Participation.where(user_id: user_id, event_id: event_id)
    drink_payments = DrinkPayment.where(participation: participation)
  end
end