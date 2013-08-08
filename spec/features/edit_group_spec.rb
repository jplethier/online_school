require 'spec_helper'

describe 'Editing a group' do
  let(:admin) { FactoryGirl.create(:admin) }
  let(:group) { FactoryGirl.create :group, account: admin.account, name: 'Classe' }
  let(:edit_group_page) { EditGroupPage.visit(subdomain: admin.account.subdomain, id: group.id) }

  before { login_as_user admin }

  it 'successfully' do
    edit_group_page.name = 'Classe 1'

    expect { edit_group_page.create }.to change { group.reload.name }.from('Classe').to('Classe 1')
  end

  it 'with missing data' do
    expect { edit_group_page.create }.to_not change { group.reload.name }
  end
end
