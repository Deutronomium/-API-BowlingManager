FactoryGirl.define do

  sequence :user_name do |n|
    "User#{n}"
  end

  sequence :email do |e|
    "email#{e}@example.com"
  end

  sequence :phone_number do |p|
    "1111#{p}1111"
  end

  factory :user do
    user_name { generate(:user_name) }
    first_name 'Patrick'
    last_name 'Engelkes'
    email { generate(:email) }
    password 'test123'
    password_confirmation 'test123'
    city 'Rheine'
    street 'Friedenstraße 149'
    phone_number { generate(:phone_number) }
    association :club
  end
end