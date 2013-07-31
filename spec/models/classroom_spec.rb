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
end
