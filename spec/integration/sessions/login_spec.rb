require 'spec_helper'

describe '#logging in a user' do

  context 'with valid user credentials' do
    it 'should return the user' do
      FactoryGirl.create(:user, userName: 'Deutro', email: 'Test', password: 'test123', password_confirmation: 'test123')

      post '/sessions',
           {session: {
               email: 'Test',
               password: 'test123'
           }}.to_json,
           request_headers

      response.status.should eq(200)

      response.content_type.should eq(Mime::JSON)

      userJson = json(response.body)
      user = userJson[:user]
      user[:userName].should eq('Deutro')
    end
  end

  context 'with invalid user credentials' do
    it 'should return an error message' do
      post '/sessions',
           {
               session: {
                   email: 'UnknownEmail',
                   password: 'Invalid'
               }
           }.to_json,
           request_headers

      response.status.should eq(401)

      response.content_type.should eq(Mime::JSON)

      error = json(response.body)[:error]
      error[:message].should_not be nil
    end
  end
end