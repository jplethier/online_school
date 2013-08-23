class Settings::AccountsController < AuthorizedController
  def edit
    @account = current_account

    authorize! :edit, @account
  end
end
