require 'spec_helper'

describe 'checking club validity' do
  before do
    @club = FactoryGirl.create(:club, name: 'Test')
  end

  context 'club with valid data should not return an error' do
    before do
      post '/clubs/validity',
           { club: {
               name: 'NotUnqiue'
           } }.to_json,
           {
               'Accept' => 'application/json',
               'Content-Type' => 'application/json'
           }
    end

    it 'should respond with ok' do
      response.status.should eq(200)
    end
  end

  context 'user with valid data should return an error' do
    before do
      post '/clubs/validity',
            { club: {
                name: 'Test'
            } }.to_json,
            {
                'Accept' => 'application/json',
                'Content-Type' => 'application/json'
            }
    end

    it 'should respond with unprocessable entity' do
      response.status.should eq(422)
    end

    it 'should respond with errors for name' do
      errors = json(response.body)
      errors[:name].should_not be nil
    end
  end

end