FactoryGirl.define do

  sequence :drinkName do |n|
    "Drink#{n}"
  end

  factory :drink do
    name { generate(:drinkName) }
    price 5.00

    association :club
  end
end