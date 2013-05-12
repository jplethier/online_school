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
      fill_in 'user_account_attributes_name', :with => 'Nome da Escola'
      fill_in 'user_account_attributes_subdomain', :with => 'escola1'
      fill_in 'user_email', :with => 'user@school.com.be'
      fill_in 'user_password', :with => '123qwe'
      fill_in 'user_password_confirmation', :with => '123qwe'
      click_on 'signup_btn'
      (User.count - 1).should == count
      (Account.count - 1).should == count
      should have_content('Cadastro realizado com sucesso. Confirme sua conta através do email enviado para a sua conta.')
    end
  end
end