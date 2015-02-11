require 'spec_helper'

describe 'checking user_validity' do
  before do
    @mail = 'MyMail'.downcase
    @user = 'MyUser'
    @not_unique_user = 'NotUniqueUser'
    @not_unique_mail = 'NotUniqueMail'.downcase
    @user = FactoryGirl.create(:user, userName: @user, email: @mail)
  end

  context 'with valid data' do
    it 'should return the checked user' do
      post '/users/validity',
           {user: {
               userName: @not_unique_user,
               email: @not_unique_mail,
               password: 'test123',
               password_confirmation: 'test123'
           }}.to_json,
           request_headers

      response.status.should eq(200)

      response.content_type.should eq(Mime::JSON)

      user = json(response.body)[:user]
      user[:userName].should eq(@not_unique_user)
      user[:email].should eq(@not_unique_mail)
    end
  end

  context 'with an existing email and username' do
    it 'should return status code 450 and an error message' do
      post '/users/validity',
           {
               user: {
                   userName: @user,
                   email: @mail,
                   password: 'test123',
                   password_confirmation: 'test123'
               }
           }.to_json,
           request_headers

      response.status.should eq(450)

      response.content_type.should eq(Mime::JSON)

      error = json(response.body)[:error]
      error[:message].should eq(UserErrors::USER_AND_EMAIL)
    end
  end

  context 'with an existing username' do
    it 'should return status code 451 and an error message' do
      post '/users/validity',
           {
               user: {
                  userName: @user,
                  email: @not_unique_mail,
                  password: 'test123',
                  password_confirmation: 'test123'
               }
           }.to_json,
           request_headers

      response.status.should eq(451)

      response.content_type.should eq(Mime::JSON)

      error = json(response.body)[:error]
      error[:message].should eq(UserErrors::USER)
    end
  end

  context 'with an existing email' do
    it 'should return status code 452 and an error message' do
      post '/users/validity',
           {
               user: {
                   userName: @not_unique_user,
                   email: @mail,
                   password: 'test123',
                   password_confirmation: 'test123'
               },
           }.to_json,
           request_headers

      response.status.should eq(452)

      response.content_type.should eq(Mime::JSON)

      error = json(response.body)[:error]
      error[:message].should eq(UserErrors::EMAIL)
    end
  end
end