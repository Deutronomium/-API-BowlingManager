class Drink < ActiveRecord::Base
  #Validations
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true

  #Associations
  belongs_to :club
  has_many :drink_payments
end