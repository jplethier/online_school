require 'spec_helper'

describe ExamsController do
  let(:account)   { stub_model(Account) }
  let(:admin)     { stub_model(User, account: account, admin: true) }
  let(:classroom) { stub_model(Classroom, account: account) }
  let(:exam)      { stub_model(Exam, account: account, classroom: classroom) }

  before { sign_in admin }

  describe 'new' do
    it 'assigns a new exam' do
      Exam.stub(new: exam)
      Classroom.stub(find: classroom)
      get :new, classroom_id: classroom.id
      expect(assigns :exam).to eq exam
    end
  end

  describe 'create' do
    before do
      Exam.stub(new: exam)
      Classroom.stub(find: classroom)
    end

    let(:params)  { { classroom_id: classroom.id, exam: { exam_date: '10/10/3010', kind: 'Prova', period: '30101' } } }

    context 'successfully' do
      before { exam.stub(save: true) }

      it 'redirects to the groups page' do
        post :create, params
        expect(response).to redirect_to classroom_path(classroom)
      end

      it 'saves the exam' do
        expect(exam).to receive :save
        post :create, params
      end
    end

    context 'unsuccessfully' do
      before { exam.stub(save: false) }

      it 'renders the new page' do
        post :create, params
        expect(response).to render_template :new
      end
    end
  end

  describe 'edit' do
    before { Exam.stub(find: exam) }

    it 'assigns the to-be-edited group' do
      get :edit, id: exam.id, classroom_id: classroom.id
      expect(assigns :exam).to eq exam
    end
  end

  describe 'update' do
    before { Exam.stub(find: exam) }

    let(:params)  { { classroom_id: classroom.id, id: exam.id, exam: { exam_date: '10/10/3010', kind: 'Prova', period: '30101' } } }

    context 'successfully' do
      before { exam.stub(update_attributes: true) }

      it 'redirects to classrooms page' do
        put :update, params
        expect(response).to redirect_to classroom_path(classroom)
      end

      it 'updates the classroom' do
        expect(exam).to receive :update_attributes
        put :update, params
      end
    end

    context 'unsuccessfully' do
      before { exam.stub(update_attributes: false) }

      it 'renders the edit page' do
        put :update, params
        expect(response).to render_template :edit
      end
    end
  end
end
