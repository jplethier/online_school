require 'spec_helper'

describe ClassroomsController do
  let(:account)   { stub_model(Account) }
  let(:admin)     { stub_model(User, account: account, admin: true) }
  let(:classroom) { stub_model(Classroom, account: account) }
  let(:groups)    { [double(:groups)] }
  let(:teachers)  { [double(:teachers)] }
  let(:subjects)  { [double(:subjects)] }

  before { sign_in admin }

  describe 'index' do
    it 'assigns all classrooms' do
      Classroom.stub_chain(:accessible_by, :ordered_by_name, :page) { [classroom] }

      get :index
      expect(assigns :classrooms).to eq [classroom]
    end

    it 'searches when the query is present' do
      Classroom.stub(search: [classroom])

      get :index, search: 'something'
      expect(assigns :classrooms).to eq [classroom]
    end
  end

  describe 'new' do
    it 'assigns a new classroom' do
      Classroom.stub(new: classroom)

      get :new
      expect(assigns :classroom).to eq classroom
    end

    it 'populates a list with all groups, all teachers and all subjects' do
      admin.stub_chain(:account, :groups) { groups }
      admin.stub_chain(:account, :subjects) { subjects }
      admin.stub_chain(:account, :users, :teachers) { teachers }

      get :new
      expect(assigns :groups).to eq groups
      expect(assigns :subjects).to eq subjects
      expect(assigns :teachers).to eq teachers
    end
  end

  describe 'create' do
    before { Classroom.stub(new: classroom) }

    let(:params)  { { classroom: { subject_id: 1 } } }

    context 'successfully' do
      before { classroom.stub(save: true) }

      it 'redirects to the groups page' do
        post :create, params
        expect(response).to redirect_to classrooms_path
      end

      it 'saves the classroom' do
        expect(classroom).to receive :save
        post :create, params
      end
    end

    context 'unsuccessfully' do
      before { classroom.stub(save: false) }

      it 'renders the new page' do
        post :create, params
        expect(response).to render_template :new
      end

      it 'populates a list with all groups, all teachers and all subjects' do
        admin.stub_chain(:account, :groups) { groups }
        admin.stub_chain(:account, :subjects) { subjects }
        admin.stub_chain(:account, :users, :teachers) { teachers }

        post :create, params
        expect(assigns :groups).to eq groups
        expect(assigns :subjects).to eq subjects
        expect(assigns :teachers).to eq teachers
      end
    end
  end

  describe 'edit' do
    before { Classroom.stub(find: classroom) }

    it 'assigns the to-be-edited group' do
      get :edit, id: classroom.id
      expect(assigns :classroom).to eq classroom
    end

    it 'populates a list with all groups, all teachers and all subjects' do
      admin.stub_chain(:account, :groups) { groups }
      admin.stub_chain(:account, :subjects) { subjects }
      admin.stub_chain(:account, :users, :teachers) { teachers }

      get :edit, id: classroom.id
      expect(assigns :groups).to eq groups
      expect(assigns :subjects).to eq subjects
      expect(assigns :teachers).to eq teachers
    end
  end

  describe 'update' do
    before { Classroom.stub(find: classroom) }

    let(:params)  { { id: classroom.id, classroom: { subject_id: 1 } } }

    context 'successfully' do
      before { classroom.stub(update_attributes: true) }

      it 'redirects to classrooms page' do
        put :update, params
        expect(response).to redirect_to classrooms_path
      end

      it 'updates the classroom' do
        expect(classroom).to receive :update_attributes
        put :update, params
      end
    end

    context 'unsuccessfully' do
      before { classroom.stub(update_attributes: false) }

      it 'renders the edit page' do
        put :update, params
        expect(response).to render_template :edit
      end

      it 'populates a list with all groups, all teachers and all subjects' do
        admin.stub_chain(:account, :groups) { groups }
        admin.stub_chain(:account, :subjects) { subjects }
        admin.stub_chain(:account, :users, :teachers) { teachers }

        put :update, params
        expect(assigns :groups).to eq groups
        expect(assigns :subjects).to eq subjects
        expect(assigns :teachers).to eq teachers
      end
    end
  end

  describe 'show' do
    let(:past_exam) { Exam.stub(account: account, classroom: classroom) }
    let(:future_exam) { Exam.stub(account: account, classroom: classroom) }

    before { Classroom.stub(find: classroom) }

    it 'assigns classroom' do
      get :show, id: classroom.id
      expect(assigns :classroom).to eq classroom
    end

    it 'populates past and future classroom exams' do
      classroom.stub_chain(:exams, :past) { [past_exam] }
      classroom.stub_chain(:exams, :future) { [future_exam] }
      get :show, id: classroom.id
      expect(assigns :past_exams).to eq [past_exam]
      expect(assigns :future_exams).to eq [future_exam]
    end
  end
end
