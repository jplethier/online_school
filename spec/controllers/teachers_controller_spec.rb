require 'spec_helper'

describe TeachersController do
  let(:account) { stub_model(Account) }
  let(:admin)   { stub_model(User, account: account, admin: true) }
  let(:teacher) { stub_model(User, account: account, teacher: true) }
  let(:cities)  { [double(:cities)] }
  let(:states)  { [double(:states)] }

  before { sign_in admin }

  describe 'index' do
    it 'assigns all teachers' do
      User.stub_chain(:teachers, :ordered_by_name) { [teacher] }

      get :index
      expect(assigns :teachers).to eq [teacher]
    end

    it 'searches when the query is present' do
      User.stub_chain(:teachers, :ordered_by_name, :search) { [teacher] }

      get :index, search: 'something'
      expect(assigns :teachers).to eq [teacher]
    end
  end

  describe 'new' do
    it 'assigns a teacher' do
      get :new
      expect(assigns :teacher).to be_teacher
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
    before { User.stub(new: teacher) }

    let(:params)  { { user: { password: :any } } }

    context 'successfully' do
      before { teacher.stub(save: true) }

      it 'redirects to the teacher page' do
        post :create, params
        expect(response).to redirect_to teachers_path
      end

      it 'saves the teacher' do
        expect(teacher).to receive :save
        post :create, params
      end
    end

    context 'unsuccessfully' do
      before { teacher.stub(save: false) }

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
        teacher.stub(address_state?: true)
        City.stub(:name_list) { cities }

        post :create, params
      end
    end
  end

  describe 'edit' do
    before { User.stub(find: teacher) }

    it 'assigns the to-be-edited teacher' do
      get :edit, id: teacher.id
      expect(assigns :teacher).to eq teacher
    end

    it 'populates a list with all states' do
      City.stub_chain(:uf_list, :collect) { states }

      get :edit, id: teacher.id
      expect(assigns :states).to eq states
    end

    it 'populates a list with all cities from the selected state' do
      teacher.stub(address_state?: true)
      City.stub(:name_list) { cities }

      get :edit, id: teacher.id
      expect(assigns :cities).to eq cities
    end
  end

  describe 'update' do
    before { User.stub(find: teacher) }

    let(:params)  { { id: teacher.id, user: { password: :any } } }

    context 'successfully' do
      before { teacher.stub(update_attributes: true) }

      it 'redirects to the teacher page' do
        put :update, params
        expect(response).to redirect_to teachers_path
      end

      it 'updates the teacher' do
        expect(teacher).to receive :update_attributes
        put :update, params
      end
    end

    context 'unsuccessfully' do
      before { teacher.stub(update_attributes: false) }

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
        teacher.stub(address_state?: true)
        City.stub(:name_list) { cities }

        put :update, params
        expect(assigns :cities).to eq cities
      end
    end
  end
end
