require 'spec_helper'
require 'drink'

describe Drink do
  subject(:drink) { FactoryGirl.build(:drink) }

  context 'factory' do
    it 'has a valid factory' do
      drink.should be_valid
    end
  end

  context 'fields' do
    it 'should be invalid without a name' do
      drink.name = nil
      drink.should_not be_valid
    end

    it 'should be invalid without a price' do
      drink.price = nil
      drink.should_not be_valid
    end

    it 'should be invalid without a unique name' do
      drinkName = 'Test'
      FactoryGirl.create(:drink, name: drinkName)
      drink.name = drinkName
      drink.should_not be_valid
    end
  end

  context 'associations' do
    it { should belong_to(:club) }
  end


end