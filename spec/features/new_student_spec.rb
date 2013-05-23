# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "New Student" do
  include Warden::Test::Helpers
  Warden.test_mode!

  subject { page }

  let(:admin) { FactoryGirl.create(:admin_user) }

  before do
    admin.confirm!
    login_as_user admin
    visit new_student_path
  end

  describe 'creating a student' do
    it 'successfully' do
      within 'article' do
        fill_in 'user_name', :with => 'Aluno'
        fill_in 'user_email', :with => 'aluno@escola.com'
        fill_in 'user_password', :with => '123qwe'
        fill_in 'user_password_confirmation', :with => '123qwe'
        expect { click_on 'Confirmar' }.to change { User.students.count }.by(1)
      end
    end

    it 'unsuccessfully' do
      within 'article' do
        fill_in 'user_name', :with => 'Aluno'
        # fill_in 'user_email', :with => 'aluno@escola.com'
        fill_in 'user_password', :with => '123qwe'
        fill_in 'user_password_confirmation', :with => '123qwe'
        expect { click_on 'Confirmar' }.to_not change { User.students.count }
      end
    end
  end
end
