require 'spec_helper'

describe Settings::AccountsController do
  let(:account) { stub_model(Account) }
  let(:admin)   { stub_model(User, account: account, admin: true) }

  before { sign_in admin }

  describe 'edit' do
    it 'assigns the current user account' do
      get :edit
      expect(assigns :account).to eq account
    end
  end

  describe 'update' do
    let(:params)  { { account: { name: :any } } }

    context 'successfully' do
      before { account.stub(update_attributes: true) }

      it 'redirects to the account settings page' do
        put :update, params
        expect(response).to redirect_to edit_settings_account_path
      end

      it 'updates the account' do
        expect(account).to receive :update_attributes
        put :update, params
      end
    end

    context 'unsuccessfully' do
      before { account.stub(update_attributes: false) }

      it 'renders the edit page' do
        put :update, params
        expect(response).to render_template :edit
      end
    end
  end
end
