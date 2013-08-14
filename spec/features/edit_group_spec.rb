require 'spec_helper'

describe 'Editing a group' do
  let(:admin) { FactoryGirl.create(:admin) }
  let(:group) { FactoryGirl.create :group, account: admin.account, name: 'Classe' }
  let(:student1) { FactoryGirl.create :student, name: 'student 1', account: admin.account }
  let(:student2) { FactoryGirl.create :student, name: 'student 2', account: admin.account }
  let!(:student3) { FactoryGirl.create :student, name: 'student 3', account: admin.account }
  let!(:user_group1) { FactoryGirl.create :user_group, user: student1, group: group }
  let!(:user_group2) { FactoryGirl.create :user_group, user: student2, group: group }
  let(:edit_group_page) { EditGroupPage.visit(subdomain: admin.account.subdomain, id: group.id) }

  before { login_as_user admin }

  context 'with students' do
    it 'removes a student', js: true do
      edit_group_page.remove_student student1
      expect { edit_group_page.create }.to change{ Group.last }.by(-1)
    end

    it 'adds another student', js: true do
      edit_group_page.add_student student3
      expect { edit_group_page.create }.to change{ Group.last }.by(1)
    end
  end

  it 'successfully' do
    edit_group_page.name = 'Classe 1'

    expect { edit_group_page.create }.to change { group.reload.name }.from('Classe').to('Classe 1')
  end

  it 'with missing data' do
    expect { edit_group_page.create }.to_not change { group.reload.name }
  end
end
