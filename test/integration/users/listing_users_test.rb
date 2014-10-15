require 'test_helper'

class ListingUsersTest < ActionDispatch::IntegrationTest
  setup do
    @club = Club.create!(name: 'Glühwürmchen')

    @club.users.create!(userName: 'Deutro', firstName: 'Patrick', lastName: 'Engelkes', password: 'test', password_confirmation: 'test', email: 'test@test.de' )
    @club.users.create!(userName: 'Munni', firstName: 'Monique', lastName: 'Toepsch', password: 'test', password_confirmation: 'test', email: 'test@test.de' )
  end

  test 'listing users' do
    get '/users'

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type

    users = json(response.body)[:users]
    assert_equal User.count, users.size
    user = User.find(users.first[:id])
    assert_equal @club.id, user.club.id
  end

  test 'filter user by username' do
    get '/users?userName=Deutro'

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type

    assert_equal 1, json(response.body)[:users].size
  end
end
