class Event < ActiveRecord::Base
  validates :club_id, presence: true

  belongs_to :club

  has_many :participations
  has_many :users, :through => :participations
end
