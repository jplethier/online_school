require 'spec_helper'

describe Entry do
  let(:entry) { FactoryGirl.build :entry }

  subject { entry }

  its(:valid?) { should be_true }

  describe 'validations' do
    it 'requires a classroom' do
      expect { entry.classroom = nil }.to change{ entry.valid? }.from(true).to(false)
    end

    it 'requires a user group' do
      expect { entry.user_group = nil }.to change{ entry.valid? }.from(true).to(false)
    end

    it 'only allows one entry per user group and classroom' do
      duplicated_entry = FactoryGirl.build :entry, classroom: entry.classroom, user_group: entry.user_group

      expect { entry.save! }.to change { duplicated_entry.valid? }.to(false)
    end
  end
end
