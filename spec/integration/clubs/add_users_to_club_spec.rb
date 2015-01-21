require 'spec_helper'

describe 'adding friends to a club' do

  before do
    FactoryGirl.create(:club, name: 'Test')
    FactoryGirl.create(:user, phone_number: '11111', club: nil)
    FactoryGirl.create(:user, phone_number: '22222', club: nil)
    FactoryGirl.create(:user, phone_number: '33333', club: nil)
    FactoryGirl.create(:user, phone_number: '44444', club: nil)
    FactoryGirl.create(:user, phone_number: '55555', club: nil)

    post '/clubs/add_members',
         {
             club: {
                 name: 'Test',
                 members: %w(11111 22222 44444)
             }
         }.to_json,
        {
            'Accept' => 'application/json',
            'Content-Type' => 'application/json'
        }
  end

  context 'answer type' do
    it 'should respond with status ok' do
      response.should be_success
    end
  end

  context 'users added to club' do
    it 'club should have 3 users' do
      club = Club.find(1)
      club.users.count.should eq(3)
    end
  end




end