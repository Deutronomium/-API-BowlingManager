class Event < ActiveRecord::Base
  #Validation
  validates :name, presence: true
  validates :date, presence: true
  validates :club_id, presence: true

  #Associations
  belongs_to :club
  has_many :participations
  has_many :users, :through => :participations
end
