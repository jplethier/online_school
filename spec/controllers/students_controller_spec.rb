require 'spec_helper'

describe StudentsController do
  let(:account) { stub_model(Account) }
  let(:admin)   { stub_model(User, account: account, admin: true) }
  let(:student) { stub_model(User, account: account, student: true) }
  let(:cities)  { [double(:cities)] }
  let(:states)  { [double(:states)] }
  let(:groups)  { [double(:groups)] }

  before { sign_in admin }

  describe 'index' do
    it 'assigns all students' do
      User.stub_chain(:students, :ordered_by_name) { [student] }

      get :index
      expect(assigns :students).to eq [student]
    end

    it 'searches when the query is present' do
      User.stub_chain(:students, :ordered_by_name, :search) { [student] }

      get :index, search: 'something'
      expect(assigns :students).to eq [student]
    end
  end

  describe 'new' do
    it 'assigns a student' do
      get :new
      expect(assigns :student).to be_student
    end

    it 'populates a list with all states' do
      City.stub_chain(:order, :select, :uniq, :collect) { states }

      get :new
      expect(assigns :states).to eq states
    end

    it 'has an empty list of cities' do
      get :new
      expect(assigns :cities).to eq []
    end

    it 'populates a list with all groups' do
      account.stub_chain(:groups, :collect) { groups }

      get :new
      expect(assigns :groups).to eq groups
    end
  end

  describe 'create' do
    before { User.stub(new: student) }

    let(:params)  { { user: { password: :any } } }

    context 'successfully' do
      before { student.stub(save: true) }

      it 'redirects to the student page' do
        post :create, params
        expect(response).to redirect_to students_path
      end

      it 'saves the student' do
        expect(student).to receive :save
        post :create, params
      end
    end

    context 'unsuccessfully' do
      before { student.stub(save: false) }

      it 'renders the new page' do
        post :create, params
        expect(response).to render_template :new
      end

      it 'populates a list with all the states' do
        City.stub_chain(:order, :select, :uniq, :collect) { states }

        post :create, params
        expect(assigns :states).to eq states
      end

      it 'populates a list with all cities from the selected state' do
        student.stub(address_state?: true)
        City.stub_chain(:select, :find_by_uf, :collect) { cities }

        post :create, params
      end

      it 'populates a list with all groups' do
        account.stub_chain(:groups, :collect) { groups }

        put :create, params
        expect(assigns :groups).to eq groups
      end
    end
  end

  describe 'edit' do
    before { User.stub(find: student) }

    it 'assigns the to-be-edited student' do
      get :edit, id: student.id
      expect(assigns :student).to eq student
    end

    it 'populates a list with all states' do
      City.stub_chain(:order, :select, :uniq, :collect) { states }

      get :edit, id: student.id
      expect(assigns :states).to eq states
    end

    it 'populates a list with all cities from the selected state' do
      student.stub(address_state?: true)
      City.stub_chain(:select, :find_by_uf, :collect) { cities }

      get :edit, id: student.id
      expect(assigns :cities).to eq cities
    end

    it 'populates a list with all groups' do
      account.stub_chain(:groups, :collect) { groups }

      get :edit, id: student.id
      expect(assigns :groups).to eq groups
    end
  end

  describe 'update' do
    before { User.stub(find: student) }

    let(:params)  { { id: student.id, user: { password: :any } } }

    context 'successfully' do
      before { student.stub(update_attributes: true) }

      it 'redirects to the student page' do
        put :update, params
        expect(response).to redirect_to students_path
      end

      it 'updates the student' do
        expect(student).to receive :update_attributes
        put :update, params
      end
    end

    context 'unsuccessfully' do
      before { student.stub(update_attributes: false) }

      it 'renders the edit page' do
        put :update, params
        expect(response).to render_template :edit
      end

      it 'populates a list with all the states' do
        City.stub_chain(:order, :select, :uniq, :collect) { states }

        put :update, params
        expect(assigns :states).to eq states
      end

      it 'populates a list with all cities from the selected state' do
        student.stub(address_state?: true)
        City.stub_chain(:select, :find_by_uf, :collect) { cities }

        put :update, params
        expect(assigns :cities).to eq cities
      end

      it 'populates a list with all groups' do
        account.stub_chain(:groups, :collect) { groups }

        put :update, params
        expect(assigns :groups).to eq groups
      end
    end
  end
end
