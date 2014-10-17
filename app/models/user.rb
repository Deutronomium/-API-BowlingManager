class User < ActiveRecord::Base
  #Validation
  validates :userName, presence: true
  validates :firstName, presence: true
  validates :lastName, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true
  validates :email, presence: true

  #Before save
  before_save :downcase_email

  #Associations
  has_secure_password
  belongs_to :club
  has_many :participations
  has_many :events, :through => :participations

  #Object methods
  def downcase_email
    self.email = email.downcase
  end
end
