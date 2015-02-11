class FinePayment < ActiveRecord::Base

  #Association
  belongs_to :user
  belongs_to :event
  belongs_to :fine
end