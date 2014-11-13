require 'spec_helper'

describe '#logging in a user' do

  context '#valid user credentials' do
    before do
      FactoryGirl.create(:user)
      post '/sessions',
           { session: {
               email: 'patrick.engelkes@gmail.com',
               password: 'test123'
           } }.to_json,
           {
               'Accept' => 'application/json',
               'Content-Type' => 'application/json'
           }
    end

    context '#answer type' do
      it 'should answer with logged in' do
        response.status.should eq(201)
      end

      it 'should answer with json' do
        response.content_type.should eq(Mime::JSON)
      end
    end

    context '#content type' do
      it 'should have an info' do
        info = json(response.body)[:response]
        info.should eq('login successful')
      end
    end
  end
end