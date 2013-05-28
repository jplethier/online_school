require 'spec_helper'

describe City do
  subject { city }

  let(:city) { FactoryGirl.build :city }

  its(:valid?) { should be_true }

  describe 'validations:' do
    it 'requires a name' do
      expect { city.name = nil }.to change { city.valid? }.from(true).to(false)
    end

    it 'requires an uf' do
      expect { city.uf = nil }.to change { city.valid? }.from(true).to(false)
    end
  end
end
