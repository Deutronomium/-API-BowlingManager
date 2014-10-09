require 'test_helper'

class ListingClubsTest < ActionDispatch::IntegrationTest
  test 'lists clubs' do
    get '/clubs'

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
  end
end
