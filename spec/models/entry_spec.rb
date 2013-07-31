require 'spec_helper'

describe Entry do
  let(:entry) { FactoryGirl.build :entry }

  subject { entry }

  its(:valid?) { should be_true }

  describe 'validations' do
    it 'should require a classroom' do
      expect{ entry.classroom = nil }.to change{ entry.valid? }.from(true).to(false)
    end

    it 'should require a resource' do
      expect{ entry.resource = nil }.to change{ entry.valid? }.from(true).to(false)
    end
  end
end
