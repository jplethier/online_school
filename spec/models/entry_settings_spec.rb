require 'spec_helper'

describe EntrySettings do
  subject { entry_settings }

  let(:entry_settings) { FactoryGirl.build :entry_settings }

  its(:valid?) { should be true }

  describe 'validations' do
    it 'requires an entry' do
      expect { entry_settings.entry = nil }.to change{ entry_settings.valid? }.from(true).to(false)
    end

    it 'requires a topic' do
      expect { entry_settings.topic = nil }.to change{ entry_settings.valid? }.from(true).to(false)
    end
  end
end
