require 'spec_helper'

describe 'Search Student' do
  before { login_as_user admin }

  let(:admin) { FactoryGirl.create(:admin) }
  let(:student_page) { IndexStudent.visit(subdomain: admin.account.subdomain) }

  it 'searching for a student' do
    FactoryGirl.create :student, name: 'A', account: admin.account
    FactoryGirl.create :student, name: 'B', account: admin.account

    expect { student_page.search('A') }.to change { student_page.students.count }.from(2).to(1)
  end
end
