require 'spec_helper'

describe FriendsController do
  context 'phone numbers' do
    before do
      FactoryGirl.create(:user, phone_number: '11111')
      FactoryGirl.create(:user, phone_number: '22222')
      FactoryGirl.create(:user, phone_number: '33333')
      FactoryGirl.create(:user, phone_number: '44444')
      FactoryGirl.create(:user, phone_number: '55555')
    end

    it 'should return all registered users for the users contacts' do
      arr = %w(11111 22222 44444)
      controller.friend_phone_numbers(arr).length.should eq(3)
    end
  end
end