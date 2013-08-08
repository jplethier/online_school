require 'spec_helper'

describe GroupsController do
  let(:account)  { stub_model(Account) }
  let(:admin)    { stub_model(User, account: account, admin: true) }
  let(:group)    { stub_model(Group, account: account) }
  let(:students) { [double(:students)] }

  before { sign_in admin }

  describe 'index' do
    it 'assigns all groups' do
      Group.stub(accessible_by: [group])

      get :index
      expect(assigns :groups).to eq [group]
    end
  end

  describe 'new' do
    it 'assigns a new group' do
      Group.stub(new: group)

      get :new
      expect(assigns :group).to eq group
    end

    it 'populates a list with all students' do
      admin.stub_chain(:account, :users, :students) { students }

      get :new
      expect(assigns :students).to eq students
    end
  end

  describe 'create' do
    before { Group.stub(new: group) }

    let(:params)  { { group: { name: :any } } }

    context 'successfully' do
      before { group.stub(save: true) }

      it 'redirects to the groups page' do
        post :create, params
        expect(response).to redirect_to groups_path
      end

      it 'saves the group' do
        expect(group).to receive :save
        post :create, params
      end
    end

    context 'unsuccessfully' do
      before { group.stub(save: false) }

      it 'renders the new page' do
        post :create, params
        expect(response).to render_template :new
      end

      it 'populates a list with all students' do
        admin.stub_chain(:account, :users, :students) { students }

        post :create, params
        expect(assigns :students).to eq students
      end
    end
  end

  describe 'edit' do
    before { Group.stub(find: group) }

    it 'assigns the to-be-edited group' do
      get :edit, id: group.id
      expect(assigns :group).to eq group
    end

    it 'populates a list with all students' do
      admin.stub_chain(:account, :users, :students) { students }

      get :edit, id: group.id
      expect(assigns :students).to eq students
    end
  end

  describe 'update' do
    before { Group.stub(find: group) }

    let(:params)  { { id: group.id, group: { name: :any } } }

    context 'successfully' do
      before { group.stub(update_attributes: true) }

      it 'redirects to groups page' do
        put :update, params
        expect(response).to redirect_to groups_path
      end

      it 'updates the group' do
        expect(group).to receive :update_attributes
        put :update, params
      end
    end

    context 'unsuccessfully' do
      before { group.stub(update_attributes: false) }

      it 'renders the edit page' do
        put :update, params
        expect(response).to render_template :edit
      end

      it 'populates a list with all students' do
        admin.stub_chain(:account, :users, :students) { students }

        put :update, params
        expect(assigns :students).to eq students
      end
    end
  end
end
