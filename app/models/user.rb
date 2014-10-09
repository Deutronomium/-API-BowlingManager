class User < ActiveRecord::Base
  validates :userName, presence: true
end
