FactoryGirl.define do
  sequence :name do |n|
    "person#{n}@example.com"
  end

  factory :club do
    name { generate(:name) }
  end
end