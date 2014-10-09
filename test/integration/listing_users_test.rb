require 'test_helper'

class ListingUsersTest < ActionDispatch::IntegrationTest
  setup do
    User.create!(userName: 'Deutro', firstName: 'Patrick', lastName: 'Engelkes')
    User.create!(userName: 'Munni', firstName: 'Monique', lastName: 'Toepsch')
  end

  test 'listing users' do
    get '/users'

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type

    assert_equal User.count, JSON.parse(response.body).size
  end

  test 'filter user by username' do
    get '/users?userName=Deutro'

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type

    assert_equal 1, JSON.parse(response.body).size
  end
end
