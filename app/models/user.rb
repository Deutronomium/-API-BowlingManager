class User < ActiveRecord::Base
  #Validation
  validates :userName, presence: true, uniqueness: true
  validates :password, presence: true
  validates :password_confirmation, presence: true
  validates :email, presence: true, uniqueness: true
  validates :phone_number, presence: true, uniqueness: true

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

  def attribute_valid?(attribute_name)
    self.valid?
    self.errors[attribute_name].blank?
  end

  def email_and_user_name_valid?
    self.valid?
    print self.errors[:userName].blank?
    print self.errors[:email].blank?
    return (self.errors[:userName].blank? || self.errors[:email].blank?)
  end
end
