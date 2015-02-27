require 'spec_helper'

describe 'list all dirnk payments from given user and event' do
  before do
    @club = FactoryGirl.create(:club)

    @user = FactoryGirl.create(:user, club: @club)

    @event = FactoryGirl.create(:event)

    @participation = FactoryGirl.create(:participation, user: @user, event: @event)

    @fine_one = FactoryGirl.create(:fine, club: @club, amount: 2.00)
    @fine_two = FactoryGirl.create(:fine, club: @club, amount: 2.50)
    @fine_three = FactoryGirl.create(:fine, club: @club, amount: 3.00)

    FactoryGirl.create(:fine_payment, fine: @fine_one, participation: @participation)
    FactoryGirl.create(:fine_payment, fine: @fine_two, participation: @participation)
    FactoryGirl.create(:fine_payment, fine: @fine_three, participation: @participation)
  end

  context 'get all fine payments' do
    it 'should succeed' do
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
      participations = json(response.body)[:participations]
      fines = json(response.body)[:fines]

      fine_payments.size.should eq(3)
      participations.size.should eq(1)
      fines.size.should eq(3)
    end
  end

  context 'get total amount' do
    it 'should return the correct amount' do
      post 'fine_payments/total_by_user_and_event',
           {
               fine_payment: {
                   user_id: @user.id,
                   event_id: @event.id
               }
           }.to_json,
           request_headers

      response.status.should eq(200)

      response.content_type.should eq(Mime::JSON)

      total_amount = json(response.body)[:total_amount]
      total_amount.should eq('7.5')
    end
  end
end