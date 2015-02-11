FactoryGirl.define do
  factory :fine_payment do
    association :fine
    association :participation
  end
end