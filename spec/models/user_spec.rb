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

  describe 'validations' do
    it 'should require a name' do
      expect{ user.name = nil }.to change{ user.valid? }.from(true).to(false)
    end

    describe 'should ensure that password is at least 6 length' do
      it { expect{ user.password = '123' }.to change{ user.valid? }.from(true).to(false) }
      it { expect{ user.password = '12345' }.to change{ user.valid? }.from(true).to(false) }
    end

    it 'should require a password' do
      expect{ user.password = nil }.to change{ user.valid? }.from(true).to(false)
    end

    it 'should require an email' do
      expect{ user.email = nil }.to change{ user.valid? }.from(true).to(false)
    end
  end
end
