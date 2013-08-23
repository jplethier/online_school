class Settings::AccountsController < AuthorizedController
  def edit
    authorize! :show, :settings

    @account = current_account
  end
end
