class Fine < ActiveRecord::Base
  #Validations
  validates :name, presence: true, uniqueness: true
  validates :amount, presence: true

  #Associations
  belongs_to :club
  has_many :fine_payments
end