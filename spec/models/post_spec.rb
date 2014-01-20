require 'spec_helper'

describe Post do
  subject { post }

  let(:post) { FactoryGirl.build :post }

  its(:valid?) { should be true }

  describe 'validations' do
    it 'requires an account' do
      expect { post.account = nil }.to change{ post.valid? }.from(true).to(false)
    end

    it 'requires an user' do
      expect { post.user = nil }.to change{ post.valid? }.from(true).to(false)
    end

    it 'requires a topic' do
      expect { post.topic = nil }.to change{ post.valid? }.from(true).to(false)
    end

    it 'requires a message' do
      expect { post.message = nil }.to change{ post.valid? }.from(true).to(false)
    end
  end
end
