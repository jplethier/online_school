# == Schema Information
#
# Table name: plans
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Plan do
  let(:plan) { FactoryGirl.build :plan }

  subject { plan }

  its(:save) { should be_true }

  it { should respond_to :title }

  describe 'validations' do
    it 'should require a title' do
      expect{ plan.title = nil }.to change{ plan.valid? }.from(true).to(false)
    end
  end
end
