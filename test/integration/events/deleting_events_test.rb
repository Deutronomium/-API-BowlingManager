require 'test_helper'

class DeletingEventsTest < ActionDispatch::IntegrationTest
  setup do
    @kegeln = Event.create!(name: 'Kegeln', club_id: 1, date: DateTime.new(2014, 4, 4))
  end

  test 'delete events' do
    delete "/events/#{@kegeln.id}"

    assert_equal 204, response.status
    assert_equal 0, Event.all.size
  end
end
