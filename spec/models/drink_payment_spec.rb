require 'spec_helper'

describe DrinkPayment do
  subject(:drink_payment) { FactoryGirl.build(:drink_payment) }

  context 'factory' do
    it 'should have a valid factory' do
      drink_payment.should be_valid
    end
  end

  context 'associations' do
    it { should belong_to(:drink) }
    it { should belong_to(:participation) }
  end

  context 'by user and event methods' do
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

    it 'should return all drink_payments' do
      participations = DrinkPayment.get_drinks_by_user_and_event(@user.id, @event.id)
      participations.size.should eq(3)
    end

    it 'should return the total amounf of all drink_payments' do
      total_amount = DrinkPayment.total_amount_by_user_and_event(@user.id, @event.id)
      total_amount.should eq(7.50)
    end
  end
end