require 'spec_helper'

describe RegistrationsController do
  include Devise::TestHelpers

  describe 'building a user' do
    before { @request.env['devise.mapping'] = Devise.mappings[:user] }

    let(:account) { stub_model(Account) }
    let(:params)  { { user: { account: { field: :any }}} }
    let(:user)    { stub_model(User, account: account) }

    it 'sets the user name as Admin plus account name' do
      User.stub(new: user)
      user.should_receive(:name=).with('Admin school name')

      params[:user][:account][:name] = 'school name'
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
