require 'test_helper'

class ListingParticipationsTest < ActionDispatch::IntegrationTest
  setup do
    @club = Club.create!(name: 'Glühwürmchen')
    @Deutro = @club.users.create!(userName: 'Deutro', firstName: 'Patrick', lastName: 'Engelkes', password: 'test', password_confirmation: 'test', email: 'test@test.de')
    @Munni = @club.users.create!(userName: 'Munni', firstName: 'Monique', lastName: 'Toepsch', password: 'test', password_confirmation: 'test', email: 'test@test.de')
    @kegeln = @club.events.create!(name: 'Kegeln')
    @fahrt = @club.events.create!(name: 'Fahrt')

    @Deutro.participations.create!(event_id: @kegeln.id)
    @Munni.participations.create!(event_id: @kegeln.id)

    @Deutro.participations.create!(event_id: @fahrt.id)
    @Munni.participations.create!(event_id: @fahrt.id)
  end

  test 'listing participations' do
    get '/participations'

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    assert_equal 4, json(response.body)[:participations].size
  end

  test 'listing participations by event' do
    get '/participations?event_id=1'

    assert_equal 2, json(response.body)[:participations].size
  end

  test 'listing participations by users' do
    get '/participations?user_id=1'

    assert_equal 2, json(response.body)[:participations].size
  end
end
