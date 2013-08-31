require 'spec_helper'

describe 'Creating a classroom' do
  before { login_as_user admin }

  let(:admin) { FactoryGirl.create(:admin) }
  let(:new_classroom_page) { NewClassroomPage.visit(subdomain: admin.account.subdomain) }
  let!(:teacher) { FactoryGirl.create(:teacher, account: admin.account) }
  let!(:subjectr) { FactoryGirl.create(:subject, account: admin.account) }

  context 'with mandatory data' do
    it 'successfully', js: true  do
      new_classroom_page.fill_mandatory_fields
      expect { new_classroom_page.save }.to change { Classroom.count }.by(1)
    end

    it 'with groups', js: true do
      group = FactoryGirl.create :group, account: admin.account

      new_classroom_page.fill_mandatory_fields
      new_classroom_page.add_group group
      new_classroom_page.save

      expect(Classroom.last).to have(1).group
    end
  end

  it 'with missing data' do
    expect { new_classroom_page.save }.to_not change { Classroom.count }
  end
end
