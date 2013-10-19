# -*- encoding : utf-8 -*-
require 'spec_helper'

describe 'Creating a employee' do
  before { login_as_user admin }

  let(:admin) { FactoryGirl.create(:admin) }
  let(:new_employee_page) { NewEmployeePage.visit(subdomain: admin.account.subdomain) }

  context 'with mandatory data' do
    before { new_employee_page.fill_mandatory_fields }

    it 'successfully' do
      expect { new_employee_page.save }.to change { User.employees.count }.by(1)
    end

    it 'successfully with an avatar' do
      new_employee_page.avatar = fixture_file_path '60x75.jpeg'
      new_employee_page.save

      user = User.employees.last
      expect(user.avatar).to exist
    end
  end

  it 'with missing data' do
    new_employee_page.fill_mandatory_fields
    new_employee_page.name = ''

    expect { new_employee_page.save }.to_not change { User.employees.count }
  end
end
