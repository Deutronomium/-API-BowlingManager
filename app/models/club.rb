class Club < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 3 }, uniqueness: true

  has_many :users
  has_many :events

  def attribute_valid?(attribute_name)
    self.valid?
    self.errors[attribute_name].blank?
  end
end
