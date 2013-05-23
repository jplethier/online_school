require 'spec_helper'

describe StudentsController do

  let(:account) { stub_model(Account) }
  let(:admin)   { stub_model(User, account: account, admin: true) }
  let(:student) { stub_model(User, account: account, student: true) }

  before { sign_in admin }

  it 'new' do
    User.stub(new: student)
    get :new
    expect(assigns :student).to eq student
  end

  it 'index' do
    User.stub(students: [student])
    get :index
    expect(assigns :students).to eq [student]
  end

  describe 'create' do
    let(:params)  { { user: { password: :any } } }

    it 'successfully' do
      student.stub(save: true)
      User.stub(new: student)
      post :create, params
      expect(response).to redirect_to(students_path)
    end

    it 'failure' do
      student.stub(save: false)
      User.stub(new: student)
      post :create, params
      expect(response).to render_template(:new)
    end
  end

  it 'edit' do
    User.stub(find: student)
    get :edit, id: student.id
    expect(assigns :student).to eq student
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
