class User < ActiveRecord::Base
  validates :userName, presence: true, length: { minimum: 3 }

  belongs_to :club
end
