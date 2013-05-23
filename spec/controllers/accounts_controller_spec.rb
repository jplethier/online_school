require 'spec_helper'

describe AccountsController do
  describe 'finding an account' do
    it 'redirects to the first user login page' do
      first_user  = stub_model(User, email: 'existing@example.com', account: stub_model(Account, subdomain: 'first'))
      second_user = stub_model(User, email: 'existing@example.com', account: stub_model(Account))

      User.stub(where: [first_user, second_user])

      post :find_account, email: first_user.email
      expect(response).to redirect_to new_user_session_url(subdomain: 'first', 'user[email]' => 'existing@example.com')
    end

    it 'renders the homepage if no accounts are found' do
      User.stub(where: [])

      post :find_account, email: 'non-existing@example.com'
      expect(response).to redirect_to root_url
    end
  end
end
