require 'spec_helper'

describe 'Search Group' do
  before { login_as_user admin }

  let(:admin) { FactoryGirl.create(:admin) }
  let(:group_page) { IndexGroupPage.visit(subdomain: admin.account.subdomain) }

  it 'searching for a group' do
    FactoryGirl.create :group, name: 'A', account: admin.account
    FactoryGirl.create :group, name: 'B', account: admin.account

    expect { group_page.search('A') }.to change { group_page.groups.count }.from(2).to(1)
  end
end
