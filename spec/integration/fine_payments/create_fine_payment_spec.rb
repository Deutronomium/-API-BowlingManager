require 'spec_helper'

describe 'creating fine payment' do
  it 'should respond with success' do
    @user = FactoryGirl.create(:user)
    @event = FactoryGirl.create(:event)

    @participation = FactoryGirl.create(:participation, event_id: @event.id, user_id: @user.id)

    @fine = FactoryGirl.create(:fine)

    post '/fine_payments',
         {
             fine_payment: {
                 participation_id: @participation.id,
                 fine_id: @fine.id
             }
         }.to_json,
         request_headers

    response.status.should eq(201)

    response.content_type.should eq(Mime::JSON)

    fine_payment = json(response.body)[:fine_payment]
    fine_payment[:participation_id].should eq(@participation.id)
    fine_payment[:fine_id].should eq(@fine.id)
  end
end