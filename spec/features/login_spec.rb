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
    it 'successfully' do
      home_page = Home.visit
      home_page.email = user.email

      login_page = home_page.sign_in
      expect(login_page).to be_displayed
      expect(login_page.email).to eq user.email
    end

    it 'with an unregistered email' do
      home_page = Home.visit
      home_page.email = 'unregistered@example.com'

      home_page.sign_in
      expect(home_page).to be_displayed
      expect(home_page).to have_content 'E-mail não encontrado'
    end
  end
end
