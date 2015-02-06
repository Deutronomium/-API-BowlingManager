class Drink < ActiveRecord::Base
  #Validations
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true

  #Associations
  belongs_to :club
end