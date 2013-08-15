require 'spec_helper'

describe 'Editing a group' do
  let(:admin) { FactoryGirl.create(:admin) }
  let(:group) { FactoryGirl.create :group, account: admin.account, name: 'Classe' }
  let(:edit_group_page) { EditGroupPage.visit(subdomain: admin.account.subdomain, id: group.id) }

  before { login_as_user admin }

  context 'with students' do
    before do
      student = FactoryGirl.create :student, account: admin.account
      FactoryGirl.create :user_group, user: student, group: group
    end

    it 'removes a student', js: true do
      student = FactoryGirl.create :student, name: 'to be deleted', account: admin.account
      FactoryGirl.create :user_group, user: student, group: group

      edit_group_page.remove_student student
      expect { edit_group_page.save }.to change { group.users.count }.by(-1)
    end

    it 'adds another student', js: true do
      student = FactoryGirl.create :student, name: 'to be created', account: admin.account

      edit_group_page.add_student student
      expect { edit_group_page.save }.to change { group.users.count }.by(1)
    end
  end

  it 'successfully' do
    edit_group_page.name = 'Classe 1'

    expect { edit_group_page.save }.to change { group.reload.name }.from('Classe').to('Classe 1')
  end

  it 'with missing data' do
    expect { edit_group_page.save }.to_not change { group.reload.name }
  end
end
