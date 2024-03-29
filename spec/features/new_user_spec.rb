# -*- encoding : utf-8 -*-
require 'spec_helper'

describe 'New User' do
  describe 'creating a user' do
    let!(:plan) { FactoryGirl.create :plan}
    let(:new_user_page) { NewUserPage.visit(plan_id: plan.id.to_s) }

    it 'successfully' do
      new_user_page.fill_mandatory_fields

      user_count    = User.count
      account_count = Account.count

      new_user_page.create

      expect(User.count).to    eq user_count + 1
      expect(Account.count).to eq account_count + 1
      expect(new_user_page).to have_content 'Uma mensagem com um link de confirmação foi enviada para o seu endereço de e-mail. Por favor, abra o link para confirmar a sua conta.'
    end

    it 'with missing data' do
      new_user_page.fill_mandatory_fields
      new_user_page.account_name = ''

      user_count    = User.count
      account_count = Account.count

      new_user_page.create

      expect(User.count).to    eq user_count
      expect(Account.count).to eq account_count
      expect(new_user_page).to have_content 'Não foi possível salvar'
    end
  end
end
