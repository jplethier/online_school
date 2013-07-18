require 'spec_helper'

describe Group do
  let(:group) { FactoryGirl.build :group }

  subject{ group }

  its(:valid?) { should be_true }

  describe 'validations' do
    it 'should require a name' do
      expect{ group.name = nil }.to change{ group.valid? }.from(true).to(false)
    end
  end
end
