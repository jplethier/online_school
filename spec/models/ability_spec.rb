require 'spec_helper'
require "cancan/matchers"

describe Ability do
  context 'Any user' do
    let(:any_user)   { stub_model(User, account_id: 1) }
    let(:ability)    { Ability.new(any_user) }

    it 'can not browse the dashboard' do
      expect(ability).to_not be_able_to :index, :dashboard
    end

    it 'can not manage users' do
      user = stub_model(User, account_id: any_user.account_id)
      expect(ability).to_not be_able_to :manage, user
    end

    it 'can not manage groups' do
      group = stub_model(Group, account_id: any_user.account_id)
      expect(ability).to_not be_able_to :manage, group
    end
  end

  context 'Admin' do
    let(:admin)   { stub_model(User, admin: true, account_id: 1) }
    let(:ability) { Ability.new(admin) }

    it 'can browse the dashboard' do
      expect(ability).to be_able_to :index, :dashboard
    end

    it 'can manage users that belong to his account' do
      same_account_user      = stub_model(User, account_id: admin.account_id)
      different_account_user = stub_model(User, account_id: 'different')

      expect(ability).to be_able_to :manage, same_account_user
      expect(ability).to_not be_able_to :manage, different_account_user
    end

    it 'can manage groups that belong to his account' do
      same_account_group      = stub_model(Group, account_id: admin.account_id)
      different_account_group = stub_model(Group, account_id: 'different')

      expect(ability).to be_able_to :manage, same_account_group
      expect(ability).to_not be_able_to :manage, different_account_group
    end
  end
end
