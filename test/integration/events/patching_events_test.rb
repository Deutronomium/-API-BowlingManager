require 'test_helper'

class PatchingEventsTest < ActionDispatch::IntegrationTest
  setup { @bowling = FactoryGirl.create(:event) }

  test 'updating event' do
    patch "/events/#{@bowling.id}",
          { event: {
              name: 'Patch'
          }}.to_json,
          {
              'Accept' => Mime::JSON,
              'Content-Type' => Mime::JSON.to_s
          }

    assert_equal 200, response.status
    assert_equal 'Patch', @bowling.reload.name
  end

  test 'does not update event with invalid data' do
    patch "/events/#{@bowling.id}",
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
