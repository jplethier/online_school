require 'spec_helper'

describe UserGroup do
  let(:user_group) { FactoryGirl.build :user_group }

  subject{ user_group }

  its(:valid?) { should be_true }

  describe 'validations' do
    it 'should require a user' do
      expect{ user_group.user = nil }.to change{ user_group.valid? }.from(true).to(false)
    end

    it 'should require a group' do
      expect{ user_group.group = nil }.to change{ user_group.valid? }.from(true).to(false)
    end
  end
end
