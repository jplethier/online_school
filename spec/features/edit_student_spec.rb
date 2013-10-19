# -*- encoding : utf-8 -*-
require 'spec_helper'

describe 'Editing a student' do
  before { login_as_user admin }

  let(:admin)   { FactoryGirl.create(:admin) }
  let(:student) { FactoryGirl.create(:student, account: admin.account) }
  let(:edit_student_page) { EditStudentPage.visit(subdomain: admin.account.subdomain, id: student.id) }

  context 'with mandatory data' do
    it 'successfully adding an avatar' do
      edit_student_page.avatar = fixture_file_path '60x75.jpeg'
      edit_student_page.save

      expect(student.reload.avatar).to exist
    end

    it 'successfully removing its avatar' do
      student.avatar = fixture_file '60x75.jpeg'
      student.save!

      edit_student_page.remove_avatar
      edit_student_page.save

      expect(student.reload.avatar).to_not exist
    end
  end

  it 'with missing data' do
    edit_student_page.enrollment  = ''
    edit_student_page.name = 'Invalid student enrollment'

    expect { edit_student_page.save }.to_not change { student.reload.name }
  end
end
