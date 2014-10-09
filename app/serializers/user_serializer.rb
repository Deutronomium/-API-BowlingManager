class UserSerializer < ActiveModel::Serializer
  attributes :id, :userName, :firstName, :lastName, :mail, :street, :city, :club_id

  belongs_to :club
end
