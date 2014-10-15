class User < ActiveRecord::Base
  has_secure_password
  before_save :downcase_email

  validates :userName, presence: true, length: { minimum: 3 }

  belongs_to :club

  has_many :participations
  has_many :events, :through => :participations

  def downcase_email
    self.email = email.downcase
  end
end
