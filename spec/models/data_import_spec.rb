require 'spec_helper'

describe DataImport do
  subject { data_import }

  let(:data_import) { FactoryGirl.build :data_import }

  its(:valid?) { should be true }

  describe 'validations: ' do
    it 'requires a file' do
      expect { data_import.file = nil }.to change { data_import.valid? }.from(true).to(false)
    end
  end
end
