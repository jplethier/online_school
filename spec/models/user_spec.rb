require 'spec_helper'

describe User do
  subject { user }

  let(:user) { FactoryGirl.build :user }

  its(:valid?) { should be_true }

  describe 'validations' do
    it 'requires a name' do
      expect { user.name = nil }.to change { user.valid? }.from(true).to(false)
    end

    describe 'ensures that password is at least 6 length' do
      it { expect { user.password = '123' }.  to change { user.valid? }.from(true).to(false) }
      it { expect { user.password = '12345' }.to change { user.valid? }.from(true).to(false) }
    end

    it 'requires a password' do
      expect { user.password = nil }.to change { user.valid? }.from(true).to(false)
    end

    it 'requires an email' do
      expect { user.email = nil }.to change { user.valid? }.from(true).to(false)
    end
  end
end
