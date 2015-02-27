class DrinkPayment < ActiveRecord::Base

  #Association
  belongs_to :drink
  belongs_to :participation

  def self.get_drinks_by_user_and_event(user_id, event_id)
    participation = Participation.where(user_id: user_id, event_id: event_id)
    drink_payments = DrinkPayment.where(participation: participation)
  end

  def self.total_amount_by_user_and_event(user_id, event_id)
    drink_payments = get_drinks_by_user_and_event(user_id, event_id)
    total_price = 0
    drink_payments.each do |drink_payment|
      drink = Drink.find(drink_payment.drink_id)
      total_price += drink.price
    end

    return total_price
  end
end