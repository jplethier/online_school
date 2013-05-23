class AccountsController < ApplicationController
  def find_account
    user = User.where(email: find_account_params).first

    if user
      redirect_to new_user_session_url(subdomain: user.account.subdomain, 'user[email]' => user.email)
    else
      redirect_to root_url, alert: 'E-mail não encontrado'
    end
  end

  private

  def find_account_params
    params.require(:email)
  end
end
