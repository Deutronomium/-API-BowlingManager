FactoryGirl.define do
  factory :drink_payment do
    association :drink
    association :participation
  end
end