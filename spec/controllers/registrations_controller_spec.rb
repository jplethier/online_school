require 'spec_helper'

describe RegistrationsController do
  include Devise::TestHelpers

  describe 'building a user' do
    before { @request.env['devise.mapping'] = Devise.mappings[:user] }

    let(:account) { stub_model(Account) }
    let(:params)  { { user: { account: { field: :any }}} }
    let(:user)    { stub_model(User, account: account) }

    it 'sets the user account name' do
      User.stub(new: user)
      user.account.should_receive(:name=).with('user name')

      params[:user][:account][:name] = 'user name'
      get :new, params
    end

    it 'sets the user email' do
      User.stub(new: user)
      User.should_receive(:new).with(hash_including(email: 'user@example.com'))

      params[:user][:email] = 'user@example.com'
      get :new, params
    end
  end
end
