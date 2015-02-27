class FinePaymentSerializer < ActiveModel::Serializer
  ActiveModel::Serializer.setup do |config|
    config.embed = :ids
    config.embed_in_root = true
  end

  attributes :id, :participation_id, :fine_id

  has_one :participation
  has_one :fine
end