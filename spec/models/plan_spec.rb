require 'spec_helper'

describe Plan do
  subject { plan }

  let(:plan) { FactoryGirl.build :plan }

  its(:valid?) { should be_true }

  describe 'validations' do
    it 'requires a title' do
      expect { plan.title = nil }.to change { plan.valid? }.from(true).to(false)
    end
  end
end
