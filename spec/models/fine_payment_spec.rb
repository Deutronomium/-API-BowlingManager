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
end