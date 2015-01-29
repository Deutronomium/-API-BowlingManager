require 'spec_helper'

describe 'get participants from an event' do
  before do
    @club = FactoryGirl.create(:club)
    @firstUser = FactoryGirl.create(:user, club_id: @club.id)
    @secondUser = FactoryGirl.create(:user, club_id: @club.id)
    @firstEvent = FactoryGirl.create(:event, club_id: @club.id)

    FactoryGirl.create(:participation, event_id: @firstEvent.id, user_id: @firstUser.id, accept: true)
    FactoryGirl.create(:participation, event_id: @firstEvent.id, user_id: @secondUser.id, accept: true)
  end

  context 'valid data' do
    it 'should return all participants for this event' do
      post '/events/get_participants',
           {
               event: {
                   event_id: @firstEvent.id
               }
           }.to_json,
           request_heders

      response.content_type.should eq(Mime::JSON)

      response.should be_success

      participations = json(response.body)[:events]
      participations.size.should eq(2)
    end
  end

  context 'invalid data' do
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