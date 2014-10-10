class UserSerializer < ActiveModel::Serializer
  attributes :id, :userName, :firstName, :lastName, :mail, :street, :city, :club_id
end
