require 'spec_helper'

describe ClassroomsController do
  let(:account)   { stub_model(Account) }
  let(:admin)     { stub_model(User, account: account, admin: true) }
  let(:classroom) { stub_model(Classroom, account: account) }
  let(:groups)    { [double(:groups)] }

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

    it 'populates a list with all groups' do
      admin.stub_chain(:account, :groups) { groups }

      get :new
      expect(assigns :groups).to eq groups
    end
  end
end
