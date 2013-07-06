require 'spec_helper'

describe Subject do
  subject { subject }

  let (:subject) { FactoryGirl.build :subject }

  its(:valid?) { should be_true }

  describe 'validations:' do
    it 'requires a name' do
      expect { subject.name = nil }.to change { subject.valid? }.from(true).to(false)
    end
  end
end
