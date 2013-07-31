require 'spec_helper'

describe GroupsController do
  let(:account) { stub_model(Account) }
  let(:admin)   { stub_model(User, account: account, admin: true) }
  let(:group)   { stub_model(Group, account: account) }

  before { sign_in admin }

  it 'index' do
    Group.stub(accessible_by: [group])
    get :index
    expect(assigns :groups).to eq [group]
  end

  it 'new' do
    Group.stub(new: group)
    get :new
    expect(assigns :group).to eq group
  end

  it 'edit' do
    Group.stub(find: group)
    get :edit, id: group.id
    expect(assigns :group).to eq group
  end

  describe 'create' do
    let(:params)  { { group: { name: :any } } }

    context 'successfully' do
      before do
        Group.stub(new: group)
        group.stub(save: true)
      end

      it 'redirects to the groups page' do
        post :create, params
        expect(response).to redirect_to(groups_path)
      end
    end

    context 'unsuccessfully' do
      before do
        Group.stub(new: group)
        group.stub(save: false)
      end

      it 'renders the new page' do
        post :create, params
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'update' do
    let(:params)  { { id: group.id, group: { name: :any } } }

    context 'successfully' do
      before do
        Group.stub(find: group)
        group.stub(update_attributes: true)
      end

      it 'redirects to groups page' do
        put :update, params
        expect(response).to redirect_to(groups_path)
      end
    end

    context 'unsuccessfully' do
      before do
        Group.stub(find: group)
        group.stub(update_attributes: false)
      end

      it 'renders the edit page' do
        put :update, params
        expect(response).to render_template(:edit)
      end
    end
  end
end
