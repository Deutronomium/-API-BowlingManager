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
      it 'is invalid without a user_name' do
        user.user_name = nil
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
        user.user_name = 'NotUnique'
        user.email = 'NotUnique'
        user.phone_number = 'NotUnique'
      end

      it 'should be invalid with an already existing user_name' do
        user.user_name = User.first.user_name
        user.should_not be_valid
      end

      it 'should not be valid with an already existing email' do
        user.email = User.first.email
        user.should_not be_valid
      end

      it 'should not be valid with an already existing phone number' do
        user.phone_number = User.first.phone_number
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

  context '#validate attribute' do
    before do
      FactoryGirl.create(:user)
      user.phone_number = 'NotUnique'
    end

    it 'should return false for an invalid user_name' do
      user.user_name = User.first.user_name
      user.attribute_valid?('user_name').should be_false
    end

    it 'should return false for an invalid email' do
      user.email = User.first.email
      user.attribute_valid?('email').should be_false
    end
  end

  context '#validate email and user_name' do
    before do
      FactoryGirl.create(:user)
    end

    it 'should return an error if user_name and email are not unique' do
      user.user_name = User.first.user_name
      user.email = User.first.email
      user.email_and_user_name_valid?.should be_false
    end

    it 'should be true if only the email is not unique' do
      user.email = 'NotUnique'
      user.email_and_user_name_valid?.should be_true
    end

    it 'should be true if only the user_name is not unique' do
      user.user_name = 'NotUnique'
      user.email_and_user_name_valid?.should be_true
    end
  end
end