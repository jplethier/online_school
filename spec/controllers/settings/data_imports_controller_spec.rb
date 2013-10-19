require 'spec_helper'

describe Settings::DataImportsController do
  let(:account)     { stub_model(Account) }
  let(:admin)       { stub_model(User, account: account, admin: true) }
  let(:data_import) { stub_model(DataImport, account: account) }

  before { sign_in admin }

  describe 'new' do
    it 'assigns a data import' do
      DataImport.stub(new: data_import)

      get :new
      expect(assigns :data_import).to eq data_import
    end
  end

  describe 'create' do
    before { DataImport.stub(new: data_import) }

    let(:params)  { {} }

    context 'successfully' do
      before { data_import.stub(save: true) }

      it 'redirects to the data imports page' do
        post :create, params
        expect(response).to redirect_to settings_data_imports_path
      end

      it 'saves the student' do
        expect(data_import).to receive :save
        post :create, params
      end
    end

    context 'unsuccessfully' do
      before { data_import.stub(save: false) }

      it 'renders the new page' do
        post :create, params
        expect(response).to render_template :new
      end
    end
  end
end
