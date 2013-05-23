# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "New User" do

  subject { page }

  before do
    visit new_user_registration_path
  end

  describe 'creating a user' do
    it 'successfully' do
      count = User.count
      a_count = Account.count
      within 'article' do
        fill_in 'user_account_attributes_name', :with => 'Nome da Escola'
        fill_in 'user_account_attributes_subdomain', :with => 'escola1'
        fill_in 'user_email', :with => 'user@school.com.be'
        fill_in 'user_password', :with => '123qwe'
        fill_in 'user_password_confirmation', :with => '123qwe'
        click_on 'signup_btn'
      end
      (User.count - 1).should == count
      (Account.count - 1).should == a_count
      should have_content('Uma mensagem com um link de confirmação foi enviada para o seu endereço de e-mail. Por favor, abra o link para confirmar a sua conta.')
    end

    it 'unsuccessfully' do
      count = User.count
      a_count = Account.count
      within 'article' do
        fill_in 'user_account_attributes_name', :with => 'Nome da Escola'
        fill_in 'user_account_attributes_subdomain', :with => 'escola1'
        # fill_in 'user_email', :with => 'user@school.com.be'
        fill_in 'user_password', :with => '123qwe'
        fill_in 'user_password_confirmation', :with => '123qwe'
        click_on 'signup_btn'
      end
      (User.count).should == count
      (Account.count).should == a_count
      should have_content('Não foi possível salvar')
    end
  end
end
