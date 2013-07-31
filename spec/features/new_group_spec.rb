# -*- encoding : utf-8 -*-
require 'spec_helper'

describe 'Creating a group' do
  let(:admin) { FactoryGirl.create(:admin) }
  let(:new_group_page) { NewGroup.visit(subdomain: admin.account.subdomain) }

  before { login_as_user admin }

  it 'successfully' do
    new_group_page.name                  = 'Aluno'

    expect { new_group_page.create }.to change { Group.count }.by(1)
  end

  it 'with missing data' do
    expect { new_group_page.create }.to_not change { Group.count }
  end
end
