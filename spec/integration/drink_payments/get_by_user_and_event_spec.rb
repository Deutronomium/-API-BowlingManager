require 'spec_helper'

describe 'list all drink payments from given user and event' do
  context 'with valid data' do
    it 'should succeed' do
      @club = FactoryGirl.create(:club)

      @user = FactoryGirl.create(:user, club: @club)

      @event = FactoryGirl.create(:event)

      @participation = FactoryGirl.create(:participation, user: @user, event: @event)

      @drink_one = FactoryGirl.create(:drink, club: @club)
      @drink_two = FactoryGirl.create(:drink, club: @club)
      @drink_three = FactoryGirl.create(:drink, club: @club)

      FactoryGirl.create(:drink_payment, drink: @drink_one, participation: @participation)
      FactoryGirl.create(:drink_payment, drink: @drink_two, participation: @participation)
      FactoryGirl.create(:drink_payment, drink: @drink_three, participation: @participation)

      post 'drink_payments/get_by_user_and_event',
           {
               drink_payment: {
                   user_id: @user.id,
                   event_id: @event.id
               }
           }.to_json,
           request_headers

      response.status.should eq(200)

      response.content_type.should eq(Mime::JSON)

      drink_payments = json(response.body)[:drink_payments]
      drink_payments.size.should eq(3)
    end
  end
end