require 'spec_helper'

describe Account do
  subject { account }

  let (:account) { FactoryGirl.build :account }

  its(:valid?) { should be_true }

  describe 'validations:' do
    it 'requires a name' do
      expect { account.name = nil }.to change { account.valid? }.from(true).to(false)
    end

    it 'requires a contact mail' do
      expect { account.contact_mail = nil }.to change { account.valid? }.from(true).to(false)
    end

    it 'requires a plan' do
      expect { account.plan = nil }.to change { account.valid? }.from(true).to(false)
    end

    describe 'subdomain' do
      it 'is required' do
        expect { account.subdomain = nil }.to change { account.valid? }.from(true).to(false)
      end

      it 'cannot be a reserved name' do
        expect { account.subdomain = Account::ReservedSubdomains.first }.to change { account.valid? }.from(true).to(false)
      end
    end
  end
end
