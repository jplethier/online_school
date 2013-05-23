# -*- encoding : utf-8 -*-
require 'spec_helper'

describe 'New Student' do
  let(:admin) { FactoryGirl.create(:admin_user) }

  before { login_as_user admin }

  describe 'creating a student' do
    let(:new_student_page) { NewStudent.visit(subdomain: admin.account.subdomain) }

    it 'successfully' do
      new_student_page.name                  = 'Aluno'
      new_student_page.email                 = 'aluno@example.com'
      new_student_page.password              = '1234qwer'
      new_student_page.password_confirmation = '1234qwer'

      expect { new_student_page.create }.to change { User.students.count }.by(1)
    end

    it 'with missing data' do
      new_student_page.name                  = 'Aluno'
      new_student_page.password              = '1234qwer'
      new_student_page.password_confirmation = '1234qwer'

      expect { new_student_page.create }.to_not change { User.students.count }
    end
  end
end
