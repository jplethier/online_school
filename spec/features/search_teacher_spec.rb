require 'spec_helper'

describe 'Search Teacher' do
  before { login_as_user admin }

  let(:admin) { FactoryGirl.create(:admin) }
  let(:teacher_page) { IndexTeacherPage.visit(subdomain: admin.account.subdomain) }

  it 'searching for a teacher' do
    FactoryGirl.create :teacher, name: 'A', account: admin.account
    FactoryGirl.create :teacher, name: 'B', account: admin.account

    expect { teacher_page.search('A') }.to change { teacher_page.teachers.count }.from(2).to(1)
  end
end
