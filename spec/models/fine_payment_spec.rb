require 'spec_helper'

describe FinePayment do
  subject(:fine_payment) { FactoryGirl.build(:fine_payment) }

  context 'factory' do
    it 'has a valid factory' do
      fine_payment.should be_valid
    end
  end

  context 'associations' do
    it { should belong_to(:fine) }
    it { should belong_to(:participation) }
  end

  context 'by user and event methods' do
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

    it 'should return all fine payments for a user and the given event' do
      fine_payments = FinePayment.get_by_user_and_event(@user.id, @event.id)
      fine_payments.size.should eq(3)
    end

    it 'should return the total amount' do
      total_amount = FinePayment.total_by_user_and_event(@user.id, @event.id)
      total_amount.should eq(7.50)
    end
  end
end