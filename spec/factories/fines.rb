FactoryGirl.define do

  sequence :fine_name do |n|
    "Fine#{n}"
  end

  factory :fine do
    name { generate(:fine_name) }
    amount 5.00

    association :club
  end
end