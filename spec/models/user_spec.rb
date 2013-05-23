require 'spec_helper'

describe User do
  subject { user }

  let(:user) { FactoryGirl.build :user }

  its(:valid?) { should be_true }

  describe 'validations:' do
    describe 'email' do
      it 'is required' do
        expect { user.email = nil }.to change { user.valid? }.from(true).to(false)
      end

      it 'has to be a valid email' do
        user.email = 'valid@example.com'
        expect { user.email = 'invalidexample.com' }.to change { user.valid? }.from(true).to(false)
      end

      it 'is unique per account' do
        existing_user = FactoryGirl.create :user, email: 'duplicated@example.com'
        user.email = 'duplicated@example.com'

        expect { user.account = existing_user.account }.to change { user.valid? }.from(true).to(false)
      end
    end

    it 'requires a name' do
      expect { user.name = nil }.to change { user.valid? }.from(true).to(false)
    end

    describe 'password' do
      it 'is required' do
        expect { user.password = nil }.to change { user.valid? }.from(true).to(false)
      end

      it 'requires a password confirmation' do
        expect { user.password_confirmation = 'different' }.to change { user.valid? }.from(true).to(false)
      end

      describe 'ensures that password is at least 6 length' do
        it { expect { user.password = '123' }.  to change { user.valid? }.from(true).to(false) }
        it { expect { user.password = '12345' }.to change { user.valid? }.from(true).to(false) }
      end
    end

    it 'requires an email' do
      expect { user.email = nil }.to change { user.valid? }.from(true).to(false)
    end
  end
end
