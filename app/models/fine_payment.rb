class FinePayment < ActiveRecord::Base

  #Association
  belongs_to :fine
  belongs_to :participation
end