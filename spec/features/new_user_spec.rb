# -*- encoding : utf-8 -*-
require 'spec_helper'

describe 'New User' do
  describe 'creating a user' do
    let(:new_user_page) { NewUser.visit }

    it 'successfully' do
      user_count    = User.count
      account_count = Account.count

      new_user_page.account_name          = 'Nome da escola'
      new_user_page.account_subdomain     = 'subdominioescola'
      new_user_page.email                 = 'user@example.com'
      new_user_page.password              = '1234qwer'
      new_user_page.password_confirmation = '1234qwer'

      new_user_page.create

      expect(User.count).to     eq user_count + 1
      expect(Account.count).to  eq account_count + 1
      expect(new_user_page).to have_content 'Uma mensagem com um link de confirmação foi enviada para o seu endereço de e-mail. Por favor, abra o link para confirmar a sua conta.'
    end

    it 'with missing data' do
      user_count    = User.count
      account_count = Account.count

      new_user_page.account_name          = 'Nome da escola'
      new_user_page.account_subdomain     = 'subdominioescola'
      new_user_page.password              = '1234qwer'
      new_user_page.password_confirmation = '1234qwer'

      new_user_page.create

      expect(User.count).to     eq user_count
      expect(Account.count).to  eq account_count
      expect(new_user_page).to have_content 'Não foi possível salvar'
    end
  end
end
