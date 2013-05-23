require 'spec_helper'

describe TeachersController do

  let(:account) { stub_model(Account) }
  let(:admin)   { stub_model(User, account: account, admin: true) }
  let(:teacher) { stub_model(User, account: account, teacher: true) }

  before { sign_in admin }

  it 'new' do
    User.stub(new: teacher)
    get :new
    expect(assigns :teacher).to eq teacher
  end

  it 'index' do
    User.stub(teachers: [teacher])
    get :index
    expect(assigns :teachers).to eq [teacher]
  end

  describe 'create' do
    let(:params)  { { user: { password: :any } } }

    it 'successfully' do
      teacher.stub(save: true)
      User.stub(new: teacher)
      post :create, params
      expect(response).to redirect_to(teachers_path)
    end

    it 'failure' do
      teacher.stub(save: false)
      User.stub(new: teacher)
      post :create, params
      expect(response).to render_template(:new)
    end
  end

  it 'edit' do
    User.stub(find: teacher)
    get :edit, id: teacher.id
    expect(assigns :teacher).to eq teacher
  end

  describe 'update' do
    let(:params)  { { id: teacher.id, user: { password: :any } } }

    it 'successfully' do
      teacher.stub(update_attributes: true)
      User.stub(find: teacher)
      post :update, params
      expect(response).to redirect_to(teachers_path)
    end

    it 'failure' do
      teacher.stub(update_attribuets: false)
      User.stub(find: teacher)
      post :update, params
      expect(response).to render_template(:edit)
    end
  end
end
