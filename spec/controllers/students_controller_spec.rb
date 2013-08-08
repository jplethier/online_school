require 'spec_helper'

describe StudentsController do
  let(:account) { stub_model(Account) }
  let(:admin)   { stub_model(User, account: account, admin: true) }
  let(:student) { stub_model(User, account: account, student: true) }
  let(:cities)  { [double(:cities)] }
  let(:states)  { [double(:states)] }

  before { sign_in admin }

  describe 'new' do
    it 'assigns a student' do
      get :new
      expect(assigns :student).to be_student
    end

    it 'has a list with all states' do
      City.stub_chain(:order, :select, :uniq, :collect) { states }

      get :new
      expect(assigns :states).to eq states
    end

    it 'has an empty list of cities' do
      get :new
      expect(assigns :cities).to eq []
    end
  end

  it 'index' do
    User.stub_chain(:students, :ordered_by_name) { [student] }
    get :index
    expect(assigns :students).to eq [student]
  end

  describe 'create' do
    let(:params)  { { user: { password: :any } } }

    context 'successfully' do
      before do
        User.stub(new: student)
        student.stub(save: true)
      end

      it 'redirects to the student page' do
        post :create, params
        expect(response).to redirect_to(students_path)
      end
    end

    context 'unsuccessfully' do
      before do
        User.stub(new: student)
        student.stub(save: false)
      end

      it 'renders the new page' do
        post :create, params
        expect(response).to render_template(:new)
      end

      it 'has a list with all the states' do
        City.stub_chain(:order, :select, :uniq, :collect) { states }

        post :create, params
        expect(assigns :states).to eq states
      end

      it 'has a list with all cities from the selected state' do
        student.stub(address_state?: true)
        City.stub_chain(:select, :find_by_uf, :collect) { cities }

        post :create, params
        expect(assigns :cities).to eq cities
      end
    end
  end

  describe 'edit' do
    before { User.stub(find: student) }

    it 'assigns the to-be-edited student' do
      User.stub(find: student)
      get :edit, id: student.id
      expect(assigns :student).to eq student
    end

    it 'has a list with all states' do
      City.stub_chain(:order, :select, :uniq, :collect) { states }

      get :edit, id: student.id
      expect(assigns :states).to eq states
    end

    it 'has a list with all cities from the selected state' do
      student.stub(address_state?: true)
      City.stub_chain(:select, :find_by_uf, :collect) { cities }

      get :edit, id: student.id
      expect(assigns :cities).to eq cities
    end
  end

  describe 'update' do
    let(:params)  { { id: student.id, user: { password: :any } } }

    context 'successfully' do
      before do
        User.stub(find: student)
        student.stub(update_attributes: true)
      end

      it 'redirects to the student page' do
        post :update, params
        expect(response).to redirect_to(students_path)
      end
    end

    context 'unsuccessfully' do
      before do
        student.stub(update_attributes: false)
        User.stub(find: student)
      end

      it 'renders the new page' do
        post :update, params
        expect(response).to render_template(:edit)
      end

      it 'has a list with all the states' do
        City.stub_chain(:order, :select, :uniq, :collect) { states }

        post :update, params
        expect(assigns :states).to eq states
      end

      it 'has a list with all cities from the selected state' do
        student.stub(address_state?: true)
        City.stub_chain(:select, :find_by_uf, :collect) { cities }

        post :update, params
        expect(assigns :cities).to eq cities
      end
    end
  end

  describe 'update' do
    let(:params)  { { id: student.id, user: { password: :any } } }

    it 'successfully' do
      student.stub(update_attributes: true)
      User.stub(find: student)
      post :update, params
      expect(response).to redirect_to(students_path)
    end

    it 'failure' do
      student.stub(update_attribuets: false)
      User.stub(find: student)
      post :update, params
      expect(response).to render_template(:edit)
    end
  end
end
