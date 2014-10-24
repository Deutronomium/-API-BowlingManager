require 'spec_helper'

describe 'patching events' do
  let(:event) { FactoryGirl.create(:event) }
  let(:club) { event.club }

  context '#updating with valid data' do
    before do
      patch ("/events/#{event.id}"),
            { event: {
                name: 'Patch',
                date: DateTime.new(2014, 4, 4),
                club_id: club.id
            }}.to_json,
            {
                'Accept' => Mime::JSON,
                'Content-Type' => Mime::JSON.to_s
            }
    end

    context 'answer type' do
      it 'should respond with success' do
        response.status.should eq(200)
      end

      it 'should answer with json' do
        response.content_type.should eq(Mime::JSON)
      end
    end

    context 'answer content' do
      it 'should update the event name' do
        event.reload.name.should eq('Patch')
      end
    end
  end

  context '#updating with invalid data' do
    before do
      patch ("/events/#{event.id}"),
            { event: {
                name: nil,
                date: DateTime.new(2014, 4, 4),
                club_id: club.id
            }}.to_json,
            {
                'Accept' => Mime::JSON,
                'Content-Type' => Mime::JSON.to_s
            }
    end

    context '#answer type' do
      it 'should answer with unprocessable entity' do
        response.status.should eq(422)
      end

      it 'should have errors for name' do
        errors = json(response.body)
        errors[:name].should_not be nil
      end
    end
  end
end