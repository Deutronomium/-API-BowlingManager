require 'spec_helper'
require 'fine'

describe Fine do
  subject(:fine) { FactoryGirl.build(:fine) }

  context 'factory' do
    it 'has a valid factory' do
      fine.should be_valid
    end
  end

  context 'fields' do
    it 'should be invalid without a name' do
      fine.name = nil
      fine.should_not be_valid
    end

    it 'should be invalid without an amount' do
      fine.amount = nil
      fine.should_not be_valid
    end

    it 'should be invalid without a unique name' do
      fine_name = 'Test'
      FactoryGirl.create(:fine, name: fine_name)
      fine.name = fine_name
      fine.should_not be_valid
    end
  end

  context '#associations' do
    it { should belong_to(:club) }
  end
end