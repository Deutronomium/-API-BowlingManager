require 'spec_helper'
require 'user'

describe 'listing users' do
  before do
    @club = FactoryGirl.create(:club)

    FactoryGirl.create(:user, club: @club, user_name: 'Deutro')
    FactoryGirl.create(:user, club: @club, user_name: 'Munni', email: 'munni@gmail.com', phone_number: '0222222222')

    get '/users'
  end

  context 'get all users' do
    context '#answer type' do
      it 'should respond with a 200 status code' do
        response.should be_success
      end

      it 'should answer with json' do
        expect(response.content_type).to eq(Mime::JSON)
      end

    end

    context '#answer content' do
      let(:users) { json(response.body)[:users] }

      it 'should respond with the right number of users' do
        users.size.should == User.count
      end

      it 'should respond with the correct user' do
        user = User.find(users.first[:id])
        user.club.id.should == @club.id
      end
    end
  end

  context 'get by user name' do
    before do
      get '/users?user_name=Deutro'
    end

    context '#answer type' do
      it 'should respond with a 200 status code' do
        response.should be_success
      end

      it 'should answer with json' do
        expect(response.content_type).to eq(Mime::JSON)
      end
    end

    context '#answer content' do
      let(:users) { json(response.body)[:users] }

      it 'should answer with the user who has the user_name Deutro' do
        users.first[:user_name].should == User.find_by_user_name('Deutro').user_name
      end
    end
  end
end