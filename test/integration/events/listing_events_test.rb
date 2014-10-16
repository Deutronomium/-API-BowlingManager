require 'test_helper'

class ListingEventsTest < ActionDispatch::IntegrationTest
  setup do
    @glühwürmchen = FactoryGirl.create(:club)
    @schickeria = FactoryGirl.create(:club, name: 'Schickeria')

    FactoryGirl.create(:event, club: @glühwürmchen)

    FactoryGirl.create(:event, club: @schickeria)
    FactoryGirl.create(:event, club: @schickeria)
  end

  test 'listing events' do
    get '/events'

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type

    events = json(response.body)[:events]
    assert_equal Event.count, events.size
    event = Event.find(events.first[:id])
    assert_equal @glühwürmchen.id, event.club.id
  end

  test 'filter by club_id' do
    get '/events?club_id=1'

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type

    assert_equal 1, json(response.body)[:events].size
  end
end
