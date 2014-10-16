require 'test_helper'

class DeletingClubsTest < ActionDispatch::IntegrationTest
  setup do
    @club = FactoryGirl.create(:club)
  end

  test 'delete clubs' do
    delete "/clubs/#{@club.id}"

    assert_equal 204, response.status
  end
end
