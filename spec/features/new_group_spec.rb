require 'spec_helper'

describe 'Creating a group' do
  before { login_as_user admin }

  let(:admin) { FactoryGirl.create(:admin) }
  let(:new_group_page) { NewGroupPage.visit(subdomain: admin.account.subdomain) }

  context 'with mandatory data' do
    it 'successfully' do
      new_group_page.fill_mandatory_fields
      expect { new_group_page.create }.to change { Group.count }.by(1)
    end

    it 'with students', js: true do
      student = FactoryGirl.create :student, account: admin.account

      new_group_page.fill_mandatory_fields
      new_group_page.add_student student
      new_group_page.create

      expect(Group.last).to have(1).user
      #expect { new_group_page.create }.to change { Group. }.by(1)
    end
  end

  it 'with missing data' do
    expect { new_group_page.create }.to_not change { Group.count }
  end
end
