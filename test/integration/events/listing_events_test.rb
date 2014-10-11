require 'test_helper'

class ListingEventsTest < ActionDispatch::IntegrationTest
  setup do
    @club = Club.create!(name: 'Glühwürmchen')
    @secondClub = Club.create!(name: 'Schickeria')

    @club.events.create!(name: 'Kegeln')
    @secondClub.events.create!(name: 'Kegeln')
    @secondClub.events.create!(name: 'Kegeln')
  end

  test 'listing events' do
    get '/events'

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type

    events = json(response.body)[:events]
    assert_equal Event.count, events.size
    event = Event.find(events.first[:id])
    assert_equal @club.id, event.club.id
  end

  test 'filter by club_id' do
    get '/events?club_id=1'

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type

    assert_equal 1, json(response.body)[:events].size
  end
end
