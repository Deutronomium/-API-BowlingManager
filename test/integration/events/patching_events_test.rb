require 'test_helper'

class PatchingEventsTest < ActionDispatch::IntegrationTest
  setup { @event = Event.create!(name: 'Kegeln', date: DateTime.new(2014, 4, 4), club_id: 1) }

  test 'updating event' do
    patch "/events/#{@event.id}",
          { event: {
              name: 'Patch'
          }}.to_json,
          {
              'Accept' => Mime::JSON,
              'Content-Type' => Mime::JSON.to_s
          }

    assert_equal 200, response.status
    assert_equal 'Patch', @event.reload.name
  end

  test 'does not update event with invalid data' do
    patch "/events/#{@event.id}",
          { event: {
              club_id: nil
          }}.to_json,
          {
              'Accept' => Mime::JSON,
              'Content-Type' => Mime::JSON.to_s
          }

    assert_equal 422, response.status
  end
end
