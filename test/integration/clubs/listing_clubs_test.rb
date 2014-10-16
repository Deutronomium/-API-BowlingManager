require 'test_helper'

class ListingClubsTest < ActionDispatch::IntegrationTest
  setup do
    @club = FactoryGirl.create(:club)
  end

  test 'lists clubs' do
    get '/clubs'

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    assert_equal 1, json(response.body).size
  end
end
