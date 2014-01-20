require 'spec_helper'

describe Topic do
  subject { topic }

  let(:topic) { FactoryGirl.build :topic }

  its(:valid?) { should be true }

  describe 'validations' do
    it 'requires an account' do
      expect { topic.account = nil }.to change{ topic.valid? }.from(true).to(false)
    end

    it 'requires an user' do
      expect { topic.user = nil }.to change{ topic.valid? }.from(true).to(false)
    end

    it 'requires a classroom' do
      expect { topic.classroom = nil }.to change{ topic.valid? }.from(true).to(false)
    end

    it 'requires a message' do
      expect { topic.message = nil }.to change{ topic.valid? }.from(true).to(false)
    end
  end
end
