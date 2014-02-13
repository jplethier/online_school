require 'spec_helper'

describe Classroom do
  let(:classroom) { FactoryGirl.build :classroom }

  subject { classroom }

  its(:valid?) { should be_true }

  describe 'validations' do
    it 'should require a subject' do
      expect{ classroom.subject = nil }.to change{ classroom.valid? }.from(true).to(false)
    end

    it 'should require an account' do
      expect{ classroom.account = nil }.to change{ classroom.valid? }.from(true).to(false)
    end
  end

  describe 'when adding groups' do
    let(:user_groups) { FactoryGirl.create_list(:user_group, 2) }

    it 'new entries are created' do
      classroom.temporary_group_ids = user_groups.map(&:id)

      expect { classroom.save! }.to change { classroom.entries.count }.from(0).to(user_groups.count)
    end

    it 'existing entries remain untouched' do
      FactoryGirl.create(:entry, classroom: classroom, user_group: user_groups.first)

      classroom.temporary_group_ids = user_groups.map(&:id)
      expect { classroom.save! }.to change { classroom.entries.count }.from(1).to(user_groups.count)
    end
  end

  describe 'when deleting groups' do
    let(:user_groups) { FactoryGirl.create_list(:user_group, 1) }

    it 'entries are removed' do
      FactoryGirl.create(:entry, classroom: classroom, user_group: user_groups.first)

      classroom.temporary_group_ids = []
      expect { classroom.save! }.to change { classroom.entries.count }.from(1).to(0)
    end
  end

  describe 'when adding and deleting groups' do
    let(:user_groups) { FactoryGirl.create_list(:user_group, 2) }

    it 'only deleted group entries are removed' do
      FactoryGirl.create(:entry, classroom: classroom, user_group: user_groups.first)
      FactoryGirl.create(:entry, classroom: classroom, user_group: user_groups.last)

      classroom.temporary_group_ids = [user_groups.first.group_id]
      expect { classroom.save! }.to change { classroom.entries.count }.from(2).to(1)
    end
  end
end
