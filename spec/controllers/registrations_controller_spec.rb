require 'spec_helper'

describe RegistrationsController do
  include Devise::TestHelpers

  describe 'building a user' do
    before { @request.env['devise.mapping'] = Devise.mappings[:user] }

    let(:account) { stub_model(Account) }
    let(:params)  { { user: { account_attributes: {} }} }
    let(:user)    { stub_model(User, account: account) }

    it 'sets the user name as Admin plus account name' do
      User.stub(new: user)
      expect(user).to receive(:name=).with('Admin school name')

      params[:user][:account_attributes][:name] = 'school name'
      post :create, params
    end

    it 'sets the user email' do
      User.stub(new: user)
      params[:user][:email] = 'user@example.com'

      post :create, params
      expect(User).to have_received(:new).with(hash_including(email: 'user@example.com'))
    end

    it 'sets the user as admin' do
      User.stub(new: user)
      expect(user).to receive(:admin=).with(true)

      post :create, params
    end
  end
end
