# -*- encoding : utf-8 -*-
require 'spec_helper'

describe 'Editing a employee' do
  before { login_as_user admin }

  let(:admin)   { FactoryGirl.create(:admin) }
  let(:employee) { FactoryGirl.create(:employee, account: admin.account) }
  let(:edit_employee_page) { EditEmployeePage.visit(subdomain: admin.account.subdomain, id: employee.id) }

  context 'with mandatory data' do
    it 'successfully adding an avatar' do
      edit_employee_page.avatar = fixture_image '60x75.jpeg'
      edit_employee_page.save

      expect(employee.reload.avatar).to exist
    end

    it 'successfully removing its avatar' do
      employee.avatar = File.new(fixture_image '60x75.jpeg')
      employee.save!

      edit_employee_page.remove_avatar
      edit_employee_page.save

      expect(employee.reload.avatar).to_not exist
    end
  end

  it 'with missing data' do
    edit_employee_page.email  = ''
    edit_employee_page.name = 'Invalid employee email'

    expect { edit_employee_page.save }.to_not change { employee.reload.name }
  end
end
