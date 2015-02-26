require 'spec_helper'

describe 'list all dirnk payments from given user and event' do
  context 'with valid data' do
    it 'should succeed' do
      @club = FactoryGirl.create(:club)

      @user = FactoryGirl.create(:user, club: @club)

      @event = FactoryGirl.create(:event)

      @participation = FactoryGirl.create(:participation, user: @user, event: @event)

      @fine_one = FactoryGirl.create(:fine, club: @club)
      @fine_two = FactoryGirl.create(:fine, club: @club)
      @fine_three = FactoryGirl.create(:fine, club: @club)

      FactoryGirl.create(:fine_payment, fine: @fine_one, participation: @participation)
      FactoryGirl.create(:fine_payment, fine: @fine_two, participation: @participation)
      FactoryGirl.create(:fine_payment, fine: @fine_three, participation: @participation)

      post 'fine_payments/get_by_user_and_event',
           {
               fine_payment: {
                   user_id: @user.id,
                   event_id: @event.id
               }
           }.to_json,
           request_headers

      response.status.should eq(200)

      response.content_type.should eq(Mime::JSON)

      fine_payments = json(response.body)[:fine_payments]
      fine_payments.size.should eq(3)
    end
  end
end