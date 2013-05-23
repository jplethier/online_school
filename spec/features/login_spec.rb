# -*- encoding : utf-8 -*-
require 'spec_helper'

describe 'Login' do
  let(:user) { FactoryGirl.create(:admin_user, password: '123qwe', password_confirmation: '123qwe') }

  context 'in sign_in page' do
    it 'successfully' do
      login_page = Login.visit(subdomain: user.account.subdomain)

      login_page.email    = user.email
      login_page.password = user.password
      login_page.sign_in

      expect(login_page).to have_content 'Login efetuado com sucesso!'
    end
  end

  context 'in home page' do
    before do
      visit root_path
    end

    it 'successfully' do
      pending 'o login não é mais possível de ser realizado pela home'

      fill_in 'user_email', :with => user.email
      fill_in 'user_password', :with => user.password
      click_on 'Login'
      should have_content('Login efetuado com sucesso!')
    end
  end
end
