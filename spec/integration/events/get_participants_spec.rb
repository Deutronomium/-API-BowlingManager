require 'spec_helper'

describe 'Getting participants from an event' do
  before do
    @club = FactoryGirl.create(:club)
    @first_user = FactoryGirl.create(:user, club_id: @club.id)
    @second_user = FactoryGirl.create(:user, club_id: @club.id)
    @first_event = FactoryGirl.create(:event, club_id: @club.id)

    FactoryGirl.create(:participation, event_id: @first_event.id, user_id: @first_user.id, accept: true)
    FactoryGirl.create(:participation, event_id: @first_event.id, user_id: @second_user.id, accept: true)
  end

  context 'with valid data' do
    it 'should return all participants for this event' do
      post '/events/get_participants',
           {
               event: {
                   event_id: @first_event.id
               }
           }.to_json,
           request_heders

      response.content_type.should eq(Mime::JSON)

      response.should be_success

      participations = json(response.body)[:events]
      participations.size.should eq(2)
    end
  end

  context 'with invalid data' do
    it 'should return an error message' do
      post '/events/get_participants',
           {
               event: {
                   event_id: 5
               }
           }.to_json,
           request_heders

      response.status.should eq(404)

      response.content_type.should eq(Mime::JSON)

      error = json(response.body)[:error]
      error[:message].should_not be nil
    end
  end
end