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

  describe 'accessibility' do
    it { should allow_mass_assignment_of :cnpj }
    it { should allow_mass_assignment_of :name }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :cnpj }
  end

  describe 'associations' do
    it { should have_many(:users) }
  end
end
