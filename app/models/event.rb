class Event < ActiveRecord::Base
  validates :club_id, presence: true

  belongs_to :club

end
