require 'test_helper'

class ListingClubsTest < ActionDispatch::IntegrationTest
  setup do
    @club = Club.create!(name: 'Glühwürmchen')

    @club.users.create!(userName: 'Deutro', firstName: 'Patrick', lastName: 'Engelkes', password: 'test', password_confirmation: 'test', email: 'test@gmail.com')
    @club.users.create!(userName: 'Munni', firstName: 'Monique', lastName: 'Toepsch', password: 'test', password_confirmation: 'test', email: 'test@gmail.com')
  end

  test 'lists clubs' do
    get '/clubs'

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    assert_equal 1, json(response.body).size
  end
end
