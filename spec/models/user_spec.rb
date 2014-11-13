require 'spec_helper'
require 'user'

describe User do
  subject(:user) { FactoryGirl.build(:user) }

  context '#factory' do
    it 'has a valid facotry' do
      user.should be_valid
    end
  end

  context '#fields' do
    context 'presence' do
      it 'is invalid without a username' do
        user.userName = nil
        user.should_not be_valid
      end

      it 'is invalid without a password' do
        user.password = nil
        user.should_not be_valid
      end

      it 'is invalid without a password confirmation' do
        user.password_confirmation = nil
        user.should_not be_valid
      end

      it 'is invalid without an email' do
        user.email = nil
        user.should_not be_valid
      end

      it 'is invalid without a phone number' do
        user.phone_number = nil
        user.should_not be_valid
      end
    end

    context 'uniqueness' do
      before do
        FactoryGirl.create(:user)
        user.userName = 'NotUnique'
        user.email = 'NotUnique'
        user.phone_number = 'NotUnique'
      end

      it 'should be invalid with an already existing username' do
        user.userName = 'Deutro'
        user.should_not be_valid
      end

      it 'should not be valid with an already existing email' do
        user.email = 'patrick.engelkes@gmail.com'
        user.should_not be_valid
      end

      it 'should not be valid with an already existing phone number' do
        user.phone_number = '0111111111'
        user.should_not be_valid
      end
    end
  end

  context '#associations' do
    it { should belong_to(:club) }
    it { should have_many(:participations) }
    it { should have_many(:events).through(:participations) }
  end

  context '#downcase email' do
    it 'makes the email attribute lower case' do
      user.email = 'PATRICK.ENGELKES@GMAIL.COM'
      expect { user.downcase_email }.to change{ user.email }.from('PATRICK.ENGELKES@GMAIL.COM').
      to('patrick.engelkes@gmail.com')
    end

    it 'downcases an email before saving' do
      user.email = 'PATRICK.ENGELKES@GMAIL.com'
      user.save.should be_true
      user.email.should be == 'patrick.engelkes@gmail.com'
    end
  end
end