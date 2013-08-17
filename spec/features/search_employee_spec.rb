require 'spec_helper'

describe 'Search Employee' do
  before { login_as_user admin }

  let(:admin) { FactoryGirl.create(:admin) }
  let(:employee_page) { IndexEmployeePage.visit(subdomain: admin.account.subdomain) }

  it 'searching for a employee' do
    FactoryGirl.create :employee, name: 'A', account: admin.account
    FactoryGirl.create :employee, name: 'B', account: admin.account

    expect { employee_page.search('A') }.to change { employee_page.employees.count }.from(2).to(1)
  end
end
