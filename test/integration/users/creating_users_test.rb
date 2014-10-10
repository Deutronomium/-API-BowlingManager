require 'test_helper'

class CreatingUsersTest < ActionDispatch::IntegrationTest
  setup { @club = Club.create!(name: 'Glühwürmchen') }

  test 'creates new user with valid data' do
    post '/users', { user: {
        userName: 'Deutro',
        firstName: 'Patrick',
        lastName: 'Engelkes',
        mail: 'patrick.engelkes@gmail.com',
        street: 'Friedenstraße',
        club_id: @club.id,
        city: 'Rheine'
    } }.to_json,
    { 'Accept' => 'application/json',
      'Content-Type' => 'application/json' }

    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type
    user = json(response.body)[:user]
    assert_equal user_url(user[:id]), response.location

    assert_equal 'Deutro', user[:userName]
    assert_equal 'Patrick', user[:firstName]
    assert_equal 'Engelkes', user [:lastName]
    assert_equal 'patrick.engelkes@gmail.com', user [:mail]
    assert_equal 'Friedenstraße', user [:street]
    assert_equal 1, user [:club_id]
    assert_equal 'Rheine', user [:city]
  end

  test 'does not create user with invalid data' do
    post '/users', { user: {
        userName: nil,
        firstName: 'Patrick',
        lastName: 'Engelkes'
    } }.to_json,
    { 'Accept' => 'application/json',
      'Content-Type' => 'application/json' }

    assert_equal 422, response.status
  end
end
