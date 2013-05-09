# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "Login" do

  let(:user) { FactoryGirl.create(:user, password: '123qwe', password_confirmation: '123qwe') }

  subject { page }

  before do
    visit new_user_session_path
  end

  it 'successfully' do
    fill_in 'user_email', :with => user.email
    fill_in 'user_password', :with => '123qwe'
    click_on 'signin_btn'
    should have_content('Login realizado com sucesso.')
  end
end