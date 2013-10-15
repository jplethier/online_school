require 'spec_helper'

describe 'Editing a classroom' do
  let(:admin) { FactoryGirl.create(:admin) }
  let(:subject) { FactoryGirl.create :subject, account: admin.account }
  let(:teacher) { FactoryGirl.create :teacher, account: admin.account }
  let(:classroom) { FactoryGirl.create :classroom, account: admin.account, subject: subject, teacher: teacher }
  let(:edit_classroom_page) { EditClassroomPage.visit(subdomain: admin.account.subdomain, id: classroom.id) }

  before { login_as_user admin }

  context 'with groups' do
    before do
      group = FactoryGirl.create :group, account: admin.account
      FactoryGirl.create :entry, classroom: classroom, resource: group
    end

    it 'removes a group', js: true do
      group = FactoryGirl.create :group, name: 'to be deleted', account: admin.account
      FactoryGirl.create :entry, classroom: classroom, resource: group

      edit_classroom_page.remove_group group
      expect { edit_classroom_page.save }.to change { classroom.groups.count }.by(-1)
    end

    it 'adds another group', js: true do
      group = FactoryGirl.create :group, name: 'to be created', account: admin.account

      edit_classroom_page.add_group group
      expect { edit_classroom_page.save }.to change { classroom.groups.count }.by(1)
    end
  end

  it 'successfully', js: true do
    new_subject = FactoryGirl.create :subject, account: admin.account
    edit_classroom_page.choose_subject new_subject

    expect { edit_classroom_page.save }.to change { classroom.reload.subject_id }.from(subject.id).to(new_subject.id)
  end

  it 'with missing data' do
    edit_classroom_page.subject = 'Por favor selecione'
    expect { edit_classroom_page.save }.to_not change { classroom.reload.subject }
  end
end
