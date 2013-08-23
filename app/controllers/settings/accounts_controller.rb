class Settings::AccountsController < AuthorizedController
  def show
    authorize! :show, :settings

    @account = current_account
  end
end
