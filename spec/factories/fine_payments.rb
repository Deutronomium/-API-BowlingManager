FactoryGirl.define do
  factory :fine_payment do
    association :user
    association :event
    association :fine
  end
end