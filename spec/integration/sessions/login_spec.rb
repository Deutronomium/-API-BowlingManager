require 'spec_helper'

describe '#logging in a user' do
  FactoryGirl.create(:user)

  context '#valid user credentials' do
    before do
      post '/sessions',
           {
               email: 'patrick.engelkes@gmail.com',
               password: 'test123'
           }.to_json,
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

  context 'invalid user credentials' do
    before do
      post '/sessions',
           {
             email: 'wrong@wrong.de',
             password: 'wrongPassword'
           }.to_json,
           {
               'Accept' => 'application/json',
               'Content-Type' => 'application/json'
           }
    end

    context 'answer type' do
      it 'should answer with unauthorized' do
        response.status.should eq(401)
      end

      it 'should answer with json' do
        response.content_type.should eq(Mime::JSON)
      end
    end

    context 'answer content' do
      it 'should have an error' do
        error = json(response.body)[:response]
        error.should eq('login failed')
      end
    end
  end
end