class FineSerializer < ActiveModel::Serializer
  ActiveModel::Serializer.setup do |config|
    config.embed = :ids
    config.embed_in_root = false
  end

  attributes :id, :name, :amount, :club_id

  has_one :club
end