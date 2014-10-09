class User < ActiveRecord::Base
  validates :userName, presence: true

  belongs_to :club
end
