require 'spec_helper'

describe 'checking user_validity' do
  before do
    @user = FactoryGirl.create(:user)
  end

  context 'user with valid data should be valid' do
    before do
      post '/users/validity',
           { user: {
               userName: 'NotUnique',
               email: 'NotUnique',
               password: 'test123',
               password: 'test123'
           } }.to_json,
           {
               'Accept' => 'application/json',
               'Content-Type' => 'application/json'
           }
    end

    it 'should respond with ok' do
      response.status.should eq(200)
    end
  end

  context 'user with invalid data should not be valid' do
    before do
      post '/users/validity',
           { user: {
               userName: 'Deutro',
               email: 'testmail@test.de',
               password: 'test123',
               password_confirmation: 'test123'
           } }.to_json,
           {
               'Accept' => 'application/json',
               'Content-Type' => 'application/json'
           }
    end

    it 'should respond with unprocessable entity' do
      response.status.should eq(422)
    end

    it 'should respond with errors for name' do
      errors = json(response.body)
      errors[:userName].should_not be nil
    end
  end

end