require 'spec_helper'

describe 'listing all friends' do
  context 'answer type' do
    before do
      FactoryGirl.create(:user, phone_number: '11111', userName: 'phoneNumber')
      FactoryGirl.create(:user, phone_number: '22222')
      FactoryGirl.create(:user, phone_number: '33333')
      FactoryGirl.create(:user, phone_number: '44444')
      FactoryGirl.create(:user, phone_number: '55555')
      post '/friends/registeredFriends',
           { friends: {
               phone_numbers: %w(11111 22222 44444)
           } }.to_json,
           { 'Accept' => 'application/json',
             'Content-Type' => 'application/json' }
    end


    context 'response header' do
      it 'should answer with status code ok' do
        response.status.should eq(200)
      end

      it 'should answer with json' do
        expect(response.content_type).to eq(Mime::JSON)
      end
    end

    context 'response content' do
      let(:friends) { (json(response.body)[:friends]) }

      it 'should answer with the right number of users (3)' do
        friends.size.should eq(3)
      end

      it 'should answer with the right user object' do
        friend = friends.first
        friend[:userName].should eq('phoneNumber')
      end
    end
  end
end