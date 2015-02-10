require 'spec_helper'
require 'club'

describe Club do
  before do
    @club = FactoryGirl.create(:club, name: 'Test')
  end
  subject(:club) { FactoryGirl.build(:club) }


  context '#factory' do
    it 'has a valid factory' do
      club.should be_valid
    end
  end

  context '#fields' do
    it 'is invalid without a club name' do
      club.name = nil
      club.should_not be_valid
    end

    it 'is invalid with a too short club name' do
      club.name = 'Te'
      club.should_not be_valid
    end

    it 'is invalid with  an already existing name' do
      club.name = 'Test'
      club.should_not be_valid
    end
  end

  context '#associations' do
    it { should have_many(:users) }
    it { should have_many(:events) }
    it { should have_many(:drinks) }
    it { should have_many(:fines) }
  end
end