class User < ActiveRecord::Base
  validates :userName, presence: true, length: { minimum: 3 }

  belongs_to :club

  has_many :participations
  has_many :events, :through => :participations
end
