require 'spec_helper'
require 'event'

describe '#deleting events' do
  let(:event) { FactoryGirl.create(:event) }

  context '#delete event which exists in the database' do
    before do
      delete "/events/#{event.id}"
    end

    context '#answer type' do
      it 'should respond with status code 204' do
        response.status.should eq(204)
      end
    end

    context '#answer content' do
      it 'should set the event count to 0' do
        Event.all.size.should eq(0)
      end
    end
  end

  context '#delete event which does not exist in database' do
    before do
      delete "/events/123"
    end

    context '#answer type' do
      it 'should answer with unprocessable entity' do
        response.status.should eq(422)
      end

      it 'should answer with json' do
        response.content_type.should eq(Mime::JSON)
      end
    end

    context 'answer content' do
      it 'should respond with an event error' do
        error = json(response.body)[:error]
        error[:event].should_not be nil
      end
    end
  end
end