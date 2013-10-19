# -*- encoding : utf-8 -*-
require 'spec_helper'

describe 'Creating a student' do
  before { login_as_user admin }

  let(:admin) { FactoryGirl.create(:admin) }
  let(:new_student_page) { NewStudentPage.visit(subdomain: admin.account.subdomain) }

  context 'with mandatory data' do
    before { new_student_page.fill_mandatory_fields }

    it 'successfully' do
      expect { new_student_page.save }.to change { User.students.count }.by(1)
    end

    it 'successfully with an avatar' do
      new_student_page.avatar = fixture_file_path '60x75.jpeg'
      new_student_page.save

      user = User.students.last
      expect(user.avatar).to exist
    end
  end

  it 'with missing data' do
    new_student_page.fill_mandatory_fields
    new_student_page.name = ''

    expect { new_student_page.save }.to_not change { User.students.count }
  end
end
