require 'spec_helper'
require 'event'

describe '#listing events' do
  before do
    @firstClub = FactoryGirl.create(:club)
    @secondClub = FactoryGirl.create(:club, name: 'secondClub')

    @first_event = FactoryGirl.create(:event, club: @firstClub)

    FactoryGirl.create(:event, club: @secondClub)
    FactoryGirl.create(:event, club: @secondClub)

    get 'events'
  end

  context '#show events without filter' do
    context '#answer type' do
      it 'should respond with success' do
        response.status.should eq(200)
      end

      it 'should respond with json' do
        response.content_type.should eq(Mime::JSON)
      end
    end

    context '#answer content' do
      let(:events) { json(response.body)[:events] }

      it 'should return the correct number of events' do
        events.size.should eq(Event.count)
      end

      it 'should return the correct data for the events' do
        event = events.first
        event[:id].should eq(@first_event.id)
      end
    end
  end

  context 'show events filtered by club_id' do
    before do
      get 'events?club_id=1'
    end

    it 'should answer with success' do
      response.status.should eq(200)
    end

    it 'should answer with json' do
      response.content_type.should eq(Mime::JSON)
    end

    it 'should answer with the correct count for the events from the first club' do
      events = json(response.body)[:events]
      events.size.should eq(1)
    end
  end
end