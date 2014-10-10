class UserSerializer < ActiveModel::Serializer
  attributes :id, :userName, :firstName, :lastName, :mail, :street, :city, :club_id

  has_one :club
  embed :id, include: true
end
