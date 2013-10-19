# -*- encoding : utf-8 -*-
require 'spec_helper'

describe 'Creating a teacher' do
  before { login_as_user admin }

  let(:admin) { FactoryGirl.create(:admin) }
  let(:new_teacher_page) { NewTeacherPage.visit(subdomain: admin.account.subdomain) }

  context 'with mandatory data' do
    before { new_teacher_page.fill_mandatory_fields }

    it 'successfully' do
      expect { new_teacher_page.save }.to change { User.teachers.count }.by(1)
    end

    it 'successfully with an avatar' do
      new_teacher_page.avatar = fixture_file_path '60x75.jpeg'
      new_teacher_page.save

      user = User.teachers.last
      expect(user.avatar).to exist
    end
  end

  it 'with missing data' do
    new_teacher_page.fill_mandatory_fields
    new_teacher_page.name = ''

    expect { new_teacher_page.save }.to_not change { User.teachers.count }
  end
end
