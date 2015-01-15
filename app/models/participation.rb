class Participation < ActiveRecord::Base
  #Validations
  validates :user_id, presence: true
  validates :event_id, presence: true

  #Associations
  belongs_to :user
  belongs_to :event

  scope :participant, -> { where(accept: true) }
  scope :unanswered, -> { where(accept: nil) }
end
