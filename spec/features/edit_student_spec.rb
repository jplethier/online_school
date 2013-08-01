# -*- encoding : utf-8 -*-
require 'spec_helper'

describe 'Editing a student' do
  before { login_as_user admin }

  let(:admin)   { FactoryGirl.create(:admin_user) }
  let(:student) { FactoryGirl.create(:student) }
  let(:edit_student_page) { EditStudent.visit(subdomain: admin.account.subdomain, student_id: student.id) }

  it 'successfully'
  it 'with missing data'
  it 'by adding an avatar'
  it 'by removing its avatar'
end
