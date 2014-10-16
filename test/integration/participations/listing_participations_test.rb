require 'test_helper'

class ListingParticipationsTest < ActionDispatch::IntegrationTest
  setup do
    @club = FactoryGirl.create(:club)

    @Deutro = FactoryGirl.create(:user, club: @club)
    @Munni = FactoryGirl.create(:user, club: @club, userName: 'Munni')

    @bowling = FactoryGirl.create(:event)
    @driving = FactoryGirl.create(:event, name: 'Driving')

    FactoryGirl.create(:participation, event: @bowling, user: @Deutro)
    FactoryGirl.create(:participation, event: @driving, user: @Deutro)

    FactoryGirl.create(:participation, event: @bowling, user: @Munni)
    FactoryGirl.create(:participation, event: @driving, user: @Munni)
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
