require 'spec_helper'

describe '#logging in a user' do

  context 'with valid user credentials' do
    it 'should return the user' do
      FactoryGirl.create(:user, user_name: 'Deutro', email: 'Test', password: 'test123', password_confirmation: 'test123')

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
      user[:user_name].should eq('Deutro')
    end
  end

  context 'with invalid user credentials' do
    it 'should return an error message for wrong email' do
      post '/sessions',
           {
               session: {
                   email: 'NotUnique',
                   password: 'Invalid'
               }
           }.to_json,
           request_headers

      response.status.should eq(460)

      response.content_type.should eq(Mime::JSON)

      error = json(response.body)[:error]
      error[:message].should_not be nil
    end
  end

  it 'should return an error message for wrong password' do
    FactoryGirl.create(:user, email: 'unique')

    post '/sessions',
         {
             session: {
                 email: 'unique',
                 password: 'Invalid'
             }
         }.to_json,
         request_headers

    response.status.should eq(461)

    response.content_type.should eq(Mime::JSON)

    error = json(response.body)[:error]
    error[:message].should_not be nil
  end
end