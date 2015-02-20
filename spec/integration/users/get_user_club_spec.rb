require 'spec_helper'

describe 'creating users' do
  before do
    @club = FactoryGirl.create(:club, name: 'GetClubTest')
    FactoryGirl.create(:user, user_name: 'TestUser', club_id: @club.id)
    FactoryGirl.create(:user, user_name: 'WithoutClub', club_id: nil)
  end

  context '#creating user with valid data should succeed' do
    before do
      post '/users/user_club',
        {
          user: {
            user_name: 'TestUser'
          }
        }.to_json,
        {
          'Accept' => 'application/json',
          'Content-Type' => 'application/json'
        }
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

  context '#creating user without a club should not succeed' do
    before do
      post '/users/user_club',
        { user: {
          user_name: 'WithoutClub'
          } 
        }.to_json,
        { 
          'Accept' => 'application/json',
          'Content-Type' => 'application/json'
        }
    end

    context 'answer type' do
      it 'should answer with unprocessable entity' do
        response.status.should eq(450)
      end

      it 'should answer with json' do
        response.content_type.should eq(Mime::JSON)
      end
    end

    context 'answer content' do
      it 'should answer with an error message that the user has no club' do
        errorJson = json(response.body)[:error]
        message = errorJson[:message]
        message.should_not be nil
      end
    end
  end
end