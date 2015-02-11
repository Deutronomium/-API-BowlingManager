class DrinkPaymentSerializer < ActiveModel::Serializer
  ActiveModel::Serializer.setup do |config|
    config.embed = :ids
    config.embed_in_root = false
  end

  attributes :id, :participation_id, :drink_id

  has_one :participation
  has_one :drink
end