require 'spec_helper'

describe '#creating events' do
  context 'creating event with valid data' do
    let(:club) { FactoryGirl.create(:club) }

    before do
      post ('/events'),
           { event: {
               name: 'Bowling',
               club_id: club.id,
               date: DateTime.new(2014, 4, 4)
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
    end

    context '#answer content' do
      it 'should answer with the correct location' do
        event = json(response.body)
        response.location.should eq(event_url(event[:id]))
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