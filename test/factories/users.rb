FactoryGirl.define do
  factory :user do
    userName 'Deutro'
    firstName 'Patrick'
    lastName 'Engelkes'
    email 'patrick.engelkes@gmail.com'
    password 'test123'
    password_confirmation 'test123'
    city 'Rheine'
    street 'Friedenstraße 149'
    phone_number '0111111111'
    association :club
  end
end