# == Schema Information
#
# Table name: accounts
#
#  id         :integer          not null, primary key
#  cnpj       :string(21)
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Account do
  let (:account) { FactoryGirl.build :account }

  subject { account }

  its(:save) { should be_true }

  it { should respond_to :cnpj }
  it { should respond_to :name }
  it { should respond_to :users }

  describe 'validations' do
    it { expect{ account.name = nil }.to change{ account.valid? }.from(true).to(false) }
    it { expect{ account.cnpj = nil }.to change{ account.valid? }.from(true).to(false) }
  end
end
