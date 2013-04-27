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

  describe 'accessibility' do
    it { should allow_mass_assignment_of :title }
  end

  describe 'validations' do
    it { should validate_presence_of :title }
  end
end
