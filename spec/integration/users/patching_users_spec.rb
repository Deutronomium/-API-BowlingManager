require 'spec_helper'

describe '#patching users' do
  let(:user) { FactoryGirl.create(:user) }
  #before do
  #  @user = FactoryGirl.create(:user)
  #end

  context '#updating user with valid data' do
    before do
      patch ("/users/#{user.id}"),
            { user: { user_name: 'Patch', first_name: 'Test', last_name: 'Test', password: 'test', password_confirmation: 'test', email: 'test@test.de' } }.to_json,
            { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }
    end

    it 'should respond with success' do
      response.status.should eq(200)
    end

    it 'should update the user name' do
      user.reload.user_name.should eq('Patch')
    end
  end

  context '#updating user with invalid data' do
    before do
      patch ("/users/#{user.id}"),
            { user: { user_name: nil, first_name: 'Test', last_name: 'Test', password: 'test', password_confirmation: 'test', email: 'test@test.de' } }.to_json,
            { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }
    end

    it 'should respond with unprocessable entity' do
      response.status.should eq(422)
    end

    it 'should have an error for user_name' do
      error = json(response.body)
      error[:user_name].should eq(["can't be blank"])
    end


   end
end