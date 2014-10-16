require 'test_helper'

class DeletingEventsTest < ActionDispatch::IntegrationTest
  setup do
    @bowling = FactoryGirl.create(:event)
  end

  test 'delete events' do
    delete "/events/#{@bowling.id}"

    assert_equal 204, response.status
    assert_equal 0, Event.all.size
  end
end
