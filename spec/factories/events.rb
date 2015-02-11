FactoryGirl.define do
  factory :event do
    name 'Kegeln'
    association :club
    date DateTime.new(2014, 4, 4)
  end
end