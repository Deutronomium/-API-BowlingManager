class DrinkPayment < ActiveRecord::Base

  #Association
  belongs_to :drink
  belongs_to :participation
end