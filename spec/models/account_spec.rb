require 'spec_helper'

describe Account do
  subject { account }

  let (:account) { FactoryGirl.build :account }

  its(:valid?) { should be_true }

  describe 'validations' do
    it 'requires a name' do
      expect { account.name = nil }.to change { account.valid? }.from(true).to(false)
    end

    it 'requires a cnpj' do
      expect { account.cnpj = nil }.to change { account.valid? }.from(true).to(false)
    end
  end
end
