require 'spec_helper'
require 'participation'

describe Participation do
  subject(:participation) { FactoryGirl.build(:participation) }

  describe '#factory' do
    it 'has a valid factory' do
      participation.should be_valid
    end
  end

  describe '#fields' do
    it 'is invalid without a user' do
      participation.user = nil
      participation.should_not be_valid
    end

    it 'is invalid without an event' do
      participation.event = nil
      participation.should_not be_valid
    end
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:event) }
  end
end