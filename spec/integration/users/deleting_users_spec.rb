require 'spec_helper'

describe 'deleting users' do
  context 'deleting an existing user' do
    before do
      @user = FactoryGirl.create(:user, userName: 'TestUser')
    end

    context 'deleing user by id' do
      it 'should respond with status code 204' do
        delete "/users/#{@user.id}"

        response.status.should eq(204)
      end
    end
  end

  context 'deleting a non existant user' do
    before do
      delete "/users/123"
    end


    it 'should respond with unprocessable entity if user is not found' do
      response.status.should eq(422)
    end

    it 'should respond with a json error message' do
      error = json(response.body)[:error]
      error[:status].should eq('User not found')
    end
  end


end