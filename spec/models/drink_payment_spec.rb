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
end