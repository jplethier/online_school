# -*- encoding : utf-8 -*-
require 'spec_helper'

describe 'New Teacher' do
  let(:admin) { FactoryGirl.create(:admin_user) }

  before { login_as_user admin }

  describe 'creating a teacher' do
    let(:new_teacher_page) { NewTeacher.visit(subdomain: admin.account.subdomain) }

    it 'successfully' do
      new_teacher_page.name                  = 'Professor'
      new_teacher_page.email                 = 'professor@example.com'
      new_teacher_page.password              = '1234qwer'
      new_teacher_page.password_confirmation = '1234qwer'

      expect { new_teacher_page.create }.to change { User.teachers.count }.by(1)
    end

    it 'unsuccessfully' do
      new_teacher_page.name                  = 'Professor'
      new_teacher_page.password              = '1234qwer'
      new_teacher_page.password_confirmation = '1234qwer'

      expect { new_teacher_page.create }.to_not change { User.teachers.count }
    end
  end
end
