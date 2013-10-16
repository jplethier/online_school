# -*- encoding : utf-8 -*-
require 'spec_helper'

describe 'Editing a teacher' do
  before { login_as_user admin }

  let(:admin)   { FactoryGirl.create(:admin) }
  let(:teacher) { FactoryGirl.create(:teacher, account: admin.account) }
  let(:edit_teacher_page) { EditTeacherPage.visit(subdomain: admin.account.subdomain, id: teacher.id) }

  context 'with mandatory data' do
    it 'successfully adding an avatar' do
      edit_teacher_page.avatar = fixture_file_path '60x75.jpeg'
      edit_teacher_page.save

      expect(teacher.reload.avatar).to exist
    end

    it 'successfully removing its avatar' do
      teacher.avatar = fixture_file '60x75.jpeg'
      teacher.save!

      edit_teacher_page.remove_avatar
      edit_teacher_page.save

      expect(teacher.reload.avatar).to_not exist
    end
  end

  it 'with missing data' do
    edit_teacher_page.email  = ''
    edit_teacher_page.name = 'Invalid teacher email'

    expect { edit_teacher_page.save }.to_not change { teacher.reload.name }
  end
end
