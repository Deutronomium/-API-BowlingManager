require 'spec_helper'

describe 'deleting clubs' do
  let(:club) { FactoryGirl.create(:club) }

  context '#deleting a club which can be found' do
    before do
      delete ("clubs/#{club.id}")
    end

    it 'should respond without content' do
      response.status.should eq(204)
    end
  end

  context 'deleting a club which is not in the database' do
    before do
      delete ("clubs/#{123}")
    end

    it 'should respond with unprocessable entity' do
      response.status.should eq(422)
    end

    it 'should respond with a club error' do
      error = json(response.body)[:error]
      error[:club].should_not be nil
    end
  end
end