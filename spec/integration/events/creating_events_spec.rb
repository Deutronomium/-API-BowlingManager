require 'spec_helper'

describe '#creating events' do
  context 'creating event with valid data' do

    before do
      @club = FactoryGirl.create(:club, name: 'TestClub')
      FactoryGirl.create(:user, club_id: @club.id)
      FactoryGirl.create(:user, club_id: @club.id)
      post ('/events'),
           { event: {
               name: 'Bowling',
               club_id: @club.id,
               date: "2015-01-08T23:55"
           }}.to_json,
           {
               'Accept' => 'application/json',
               'Content-Type' => 'application/json'
           }
    end

    context '#answer type' do
      it 'should respond with created' do
        response.status.should eq(201)
      end

      it 'should respond with json' do
        response.content_type.should eq(Mime::JSON)
      end

      it 'should return the created event' do
        event = json(response.body)[:event]
        event[:name].should eq('Bowling')
        event[:club_id].should eq(1)
        event[:date].should eq('2015-01-08T23:55:00.000Z')
      end
    end

    context 'creating participations' do
      it 'should create participations for all club users' do 
        event = Event.find_by_name('Bowling')
        event.participations.count.should eq(2)
      end
    end
  end

  context '#creating event with invalid data' do
    before do
      post '/events',
           { event: {
               name: 'Bowling',
               club_id: nil,
               date: DateTime.new(2014, 4, 4)
           }}.to_json,
           {
               'Accept' => 'application/json',
               'Content-Type' => 'application/json'
           }
    end

    it 'should respond with unprocessable entity' do
      response.status.should eq(422)
    end

    it 'should have erros for club' do
      errors = json(response.body)
      errors[:club_id].should_not be nil
    end
  end
end