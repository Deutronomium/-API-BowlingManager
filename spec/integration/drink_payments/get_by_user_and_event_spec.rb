require 'spec_helper'

describe 'list all drink payments from given user and event' do
  before do
    @club = FactoryGirl.create(:club)

    @user = FactoryGirl.create(:user, club: @club)

    @event = FactoryGirl.create(:event)

    @participation = FactoryGirl.create(:participation, user: @user, event: @event)

    @drink_one = FactoryGirl.create(:drink, club: @club, price: 2.00)
    @drink_two = FactoryGirl.create(:drink, club: @club, price: 2.50)
    @drink_three = FactoryGirl.create(:drink, club: @club, price: 3.00)

    FactoryGirl.create(:drink_payment, drink: @drink_one, participation: @participation)
    FactoryGirl.create(:drink_payment, drink: @drink_two, participation: @participation)
    FactoryGirl.create(:drink_payment, drink: @drink_three, participation: @participation)
  end

  context 'get all drinks' do
    it 'should succeed' do
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
      participations = json(response.body)[:participations]
      drinks = json(response.body)[:drinks]

      drink_payments.size.should eq(3)
      participations.size.should eq(1)
      drinks.size.should eq(3)
    end
  end

  context 'get total price of all drinks' do
    it 'should return the correct amount' do
      post 'drink_payments/total_by_user_and_event',
           {
               drink_payment: {
                   user_id: @user.id,
                   event_id: @event.id
               }
           }.to_json,
           request_headers

      response.status.should eq(200)

      response.content_type.should eq(Mime::JSON)

      total_price = json(response.body)[:total_price]
      total_price.should eq('7.5')
    end
  end
end