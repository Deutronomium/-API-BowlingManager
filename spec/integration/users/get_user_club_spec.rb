require 'spec_helper'

describe 'creating users' do
  before do
    @club = FactoryGirl.create(:club, name: 'GetClubTest')
    FactoryGirl.create(:user, userName: 'TestUser', club_id: @club.id)
  end

  context '#creating user with valid data should succeed' do
    before do
      post '/users/user_club',
        { user: {
          userName: 'TestUser',
      } }.to_json,
           { 'Accept' => 'application/json',
             'Content-Type' => 'application/json' }
    end

    context '#answer type' do
      it 'should answer with ok' do
        response.status.should eq(200)
      end

      it 'should answer with json' do
        response.content_type.should eq(Mime::JSON)
      end
    end

    context '#answer content' do
      let(:club) { (json(response.body)[:club]) }
      it 'should respond with the correct club' do
        club[:name].should eq('GetClubTest')
      end
    end
  end
end