class UserSerializer < ActiveModel::Serializer
  ActiveModel::Serializer.setup do |config|
    config.embed = :ids
    config.embed_in_root = false
  end

  attributes :id, :userName, :firstName, :lastName, :mail, :street, :city, :club_id

  has_one :club
end
