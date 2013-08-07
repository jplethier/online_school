require 'spec_helper'

describe 'Student' do
  subject { user }

  let(:user) { FactoryGirl.build :student }

  its(:valid?) { should be_true }
end
