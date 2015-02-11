require 'spec_helper'

describe 'creating a drink payment' do
  it 'should return the created payment' do
    @user = FactoryGirl.create(:user)
    @event = FactoryGirl.create(:event)

    @participation = FactoryGirl.create(:participation, user_id: @user.id, event_id: @event.id)
    @drink = FactoryGirl.create(:drink)

    post '/drink_payments',
         {
             drink_payment: {
                 participation_id: @participation.id,
                 drink_id: @drink.id
             }
         }.to_json,
         request_headers

    response.status.should eq(201)

    response.content_type.should eq(Mime::JSON)

    drink_payment = json(response.body)[:drink_payment]
    drink_payment[:particiaption_id] = @participation.id
    drink_payment[:drink_id] = @drink.id
  end
end