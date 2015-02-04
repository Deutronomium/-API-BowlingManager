require 'spec_helper'

describe 'adding friends to a club' do
  before do
    FactoryGirl.create(:club, name: 'Test')
    FactoryGirl.create(:user, phone_number: '11111', club: nil)
    FactoryGirl.create(:user, phone_number: '22222', club: nil)
    FactoryGirl.create(:user, phone_number: '33333', club: nil)
    FactoryGirl.create(:user, phone_number: '44444', club: nil)
    FactoryGirl.create(:user, phone_number: '55555', club: nil)
  end


  context 'with valid data' do
    it 'should add all users with the given phone numbers to the club' do
      post '/clubs/add_members',
           {
               club: {
                   name: 'Test',
                   members: %w(11111 22222 44444)
               }
           }.to_json,
           request_headers

      response.should be_success

      club = Club.find(1)
      club.users.count.should eq(3)
    end
  end

  context 'which does not exist' do
    it 'should send an error message' do
      post '/clubs/add_members',
           {
               club: {
                   members: %w(66666 77777 88888)
               }
           }.to_json,
           request_headers

      response.status.should eq(404)

      response.content_type.should eq(Mime::JSON)

      error = json(response.body)[:error]
      error[:message].should_not be nil
    end
  end
end