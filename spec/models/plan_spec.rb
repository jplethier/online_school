require 'spec_helper'

describe Plan do
  subject { plan }

  let(:plan) { FactoryGirl.build :plan }

  its(:valid?) { should be_true }

  describe 'validations' do
    it 'requires a title' do
      expect { plan.title = nil }.to change { plan.valid? }.from(true).to(false)
    end

    it 'requires a price' do
      expect { plan.price = nil }.to change { plan.valid? }.from(true).to(false)
    end

    it 'requires a numeric price' do
      expect { plan.price = 'price' }.to change { plan.valid? }.from(true).to(false)
    end

    it 'requires a students_number' do
      expect { plan.students_number = nil }.to change { plan.valid? }.from(true).to(false)
    end

    it 'requires a integer students_number' do
      expect { plan.students_number = 'students' }.to change { plan.valid? }.from(true).to(false)
    end
  end
end
