require 'spec_helper'
require 'event'

describe Event do
  subject(:event) { FactoryGirl.build(:event) }

  context '#factory' do
    it 'has a valid factory' do
      event.should be_valid
    end
  end

  context '#fields' do
    it 'is invalid without an event name' do
      event.name = nil
      event.should_not be_valid
    end

    it 'is invalid without a date' do
      event.date = nil
      event.should_not be_valid
    end

    it 'is invalid without a club' do
      event.club = nil
      event.should_not be_valid
    end
  end

  context '#associations' do
    it { should belong_to(:club) }
    it { should have_many(:participations) }
    it { should have_many(:users).through(:participations) }
    it { should have_many(:fine_payments) }
  end
end