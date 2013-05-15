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
end
