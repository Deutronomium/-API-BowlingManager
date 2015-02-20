class UserSerializer < ActiveModel::Serializer
  ActiveModel::Serializer.setup do |config|
    config.embed = :ids
    config.embed_in_root = false
  end

  attributes :id, :user_name, :first_name, :last_name, :email, :street, :city, :club_id, :phone_number

  has_one :club
end
