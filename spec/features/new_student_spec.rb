# -*- encoding : utf-8 -*-
require 'spec_helper'

describe 'Creating a student' do
  before { login_as_user admin }

  let(:admin) { FactoryGirl.create(:admin) }
  let(:new_student_page) { NewStudent.visit(subdomain: admin.account.subdomain) }

  context 'with mandatory data' do
    before do
      new_student_page.name                  = 'Aluno'
      new_student_page.email                 = 'aluno@example.com'
      new_student_page.password              = '1234qwer'
      new_student_page.password_confirmation = '1234qwer'
    end

    it 'successfully' do
      expect { new_student_page.create }.to change { User.students.count }.by(1)
    end

    it 'successfully with an avatar' do
      new_student_page.avatar = fixture_image '60x75.jpeg'
      new_student_page.create

      user = User.students.last
      expect(user.avatar).to be_present
    end
  end

  it 'with missing data' do
    new_student_page.name                  = 'Aluno'
    new_student_page.password              = '1234qwer'
    new_student_page.password_confirmation = '1234qwer'

    expect { new_student_page.create }.to_not change { User.students.count }
  end
end
