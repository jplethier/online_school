require 'spec_helper'

describe StudentsController do
  include Devise::TestHelpers

  let(:account) { stub_model(Account) }
  let(:admin)   { stub_model(User, account: account) }
  let(:student) { stub_model(User, account: account, student: true) }

  before { sign_in admin }

  it 'new' do
    User.stub(new: student)
    get :new
    assigns(:student).should eq(student)
  end

  it 'index' do
    User.stub(students: [student])
    get :index
    assigns(:students).should eq([student])
  end

  describe 'create' do
    let(:params)  { { user: { field: :any } } }

    it 'successfully' do
      student.email = 'mail@student.edu.br'
      student.password = '123qwe'
      student.password_confirmation = '123qwe'
      student.name = 'Aluno 1'
      student.account.name = 'Escola 1'
      User.stub(new: student)
      post :create, params
      expect(response).to redirect_to(students_path)
    end

    it 'failure' do
      User.stub(new: student)
      post :create, params
      expect(response).to render_template(:new)
    end
  end
end
