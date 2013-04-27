# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  created_at             :datetime
#  updated_at             :datetime
#  name                   :string(255)
#  enrollment             :string(255)
#  phone_number           :string(255)
#  cellphone_number       :string(255)
#  birth_date             :date
#  address                :string(255)
#  address_number         :string(255)
#  address_complement     :string(255)
#  address_city           :string(255)
#  address_state          :string(255)
#  account_id             :integer
#

require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.build :user }

  subject { user }

  its(:save) { should be_true }

  it { should respond_to :name }
  it { should respond_to :email }
  it { should respond_to :password }
  it { should respond_to :enrollment }
  it { should respond_to :phone_number }
  it { should respond_to :cellphone_number }
  it { should respond_to :birth_date }
  it { should respond_to :address }
  it { should respond_to :address_number }
  it { should respond_to :address_complement }
  it { should respond_to :address_city }
  it { should respond_to :address_state }
  it { should respond_to :account }

  describe 'accessibility' do
    it { should allow_mass_assignment_of :name }
    it { should allow_mass_assignment_of :email }
    it { should allow_mass_assignment_of :password }
    it { should allow_mass_assignment_of :enrollment }
    it { should allow_mass_assignment_of :phone_number }
    it { should allow_mass_assignment_of :cellphone_number }
    it { should allow_mass_assignment_of :birth_date }
    it { should allow_mass_assignment_of :address_state }
    it { should allow_mass_assignment_of :address }
    it { should allow_mass_assignment_of :address_city }
    it { should allow_mass_assignment_of :address_complement }
    it { should allow_mass_assignment_of :address_number }
    it { should_not allow_mass_assignment_of :account_id }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should ensure_length_of(:password).is_at_least(6) }
  end

  describe 'associations' do
    it { should belong_to :account }
  end
end
