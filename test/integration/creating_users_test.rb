require 'test_helper'

class CreatingUsersTest < ActionDispatch::IntegrationTest
  test 'creates new user with valid data' do
    post '/users', { user: {
        userName: 'Deutro',
        firstName: 'Patrick',
        lastName: 'Engelkes'
    } }.to_json,
    { 'Accept' => 'application/json',
      'Content-Type' => 'application/json' }

    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type
    user = json(response.body)
    assert_equal user_url(user[:id]), response.location

    assert_equal 'Deutro', user[:userName]
    assert_equal 'Patrick', user[:firstName]
    assert_equal 'Engelkes', user [:lastName]
  end

  test 'does not create books with invalid data' do
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
