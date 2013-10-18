require 'spec_helper'

describe EmployeesController do
  let(:account)  { stub_model(Account) }
  let(:admin)    { stub_model(User, account: account, admin: true) }
  let(:employee) { stub_model(User, account: account, employee: true) }
  let(:cities)   { [double(:cities)] }
  let(:states)   { [double(:states)] }

  before { sign_in admin }

  describe 'index' do
    it 'assigns all employees' do
      User.stub_chain(:employees, :ordered_by_name) { [employee] }

      get :index
      expect(assigns :employees).to eq [employee]
    end

    it 'searches when the query is present' do
      User.stub_chain(:employees, :ordered_by_name, :search) { [employee] }

      get :index, search: 'something'
      expect(assigns :employees).to eq [employee]
    end
  end

  describe 'new' do
    it 'assigns a employee' do
      get :new
      expect(assigns :employee).to be_employee
    end

    it 'populates a list with all states' do
      City.stub_chain(:uf_list, :collect) { states }

      get :new
      expect(assigns :states).to eq states
    end

    it 'has an empty list of cities' do
      get :new
      expect(assigns :cities).to eq []
    end
  end

  describe 'create' do
    before { User.stub(new: employee) }

    let(:params)  { { user: { password: :any } } }

    context 'successfully' do
      before { employee.stub(save: true) }

      it 'redirects to the employee page' do
        post :create, params
        expect(response).to redirect_to employees_path
      end

      it 'saves the employee' do
        expect(employee).to receive :save
        post :create, params
      end
    end

    context 'unsuccessfully' do
      before { employee.stub(save: false) }

      it 'renders the new page' do
        post :create, params
        expect(response).to render_template :new
      end

      it 'populates a list with all the states' do
        City.stub_chain(:uf_list, :collect) { states }

        post :create, params
        expect(assigns :states).to eq states
      end

      it 'populates a list with all cities from the selected state' do
        employee.stub(address_state?: true)
        City.stub(:name_list) { cities }

        post :create, params
      end
    end
  end

  describe 'edit' do
    before { User.stub(find: employee) }

    it 'assigns the to-be-edited employee' do
      get :edit, id: employee.id
      expect(assigns :employee).to eq employee
    end

    it 'populates a list with all states' do
      City.stub_chain(:uf_list, :collect) { states }

      get :edit, id: employee.id
      expect(assigns :states).to eq states
    end

    it 'populates a list with all cities from the selected state' do
      employee.stub(address_state?: true)
      City.stub(:name_list) { cities }

      get :edit, id: employee.id
      expect(assigns :cities).to eq cities
    end
  end

  describe 'update' do
    before { User.stub(find: employee) }

    let(:params)  { { id: employee.id, user: { password: :any } } }

    context 'successfully' do
      before { employee.stub(update_attributes: true) }

      it 'redirects to the employee page' do
        put :update, params
        expect(response).to redirect_to employees_path
      end

      it 'updates the employee' do
        expect(employee).to receive :update_attributes
        put :update, params
      end
    end

    context 'unsuccessfully' do
      before { employee.stub(update_attributes: false) }

      it 'renders the edit page' do
        put :update, params
        expect(response).to render_template :edit
      end

      it 'populates a list with all the states' do
        City.stub_chain(:uf_list, :collect) { states }

        put :update, params
        expect(assigns :states).to eq states
      end

      it 'populates a list with all cities from the selected state' do
        employee.stub(address_state?: true)
        City.stub(:name_list) { cities }

        put :update, params
        expect(assigns :cities).to eq cities
      end
    end
  end
end
