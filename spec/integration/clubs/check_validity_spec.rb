require 'spec_helper'

describe 'Checking club validity' do
  before do
    @club = FactoryGirl.create(:club, name: 'Test')
  end

  context 'with valid data' do
    it 'should answer with success' do

      post '/clubs/validity',
           { club: {
               name: 'NotUnqiue'
           } }.to_json,
           request_headers

      response.status.should eq(200)
    end
  end


  context 'with invalid data' do
    it 'should answer with an error message' do
      post '/clubs/validity',
           { club: {
               name: 'Test'
           } }.to_json,
           request_headers
      response.status.should eq(400)

      errors = json(response.body)
      errors[:name].should_not be nil
    end
  end

end