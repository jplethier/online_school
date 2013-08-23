class Settings::AccountsController < AuthorizedController
  load_and_authorize_resource :account, through: :current_user, singleton: true

  def edit
  end

  def update
    if @account.update_attributes(account_params)
      redirect_to edit_settings_account_path, success: 'Dados da conta atualizados com sucesso.'
    else
      flash.now[:error] = 'Não foi possível atualizar os dados da conta.'
      render :edit
    end
  end

  private

  def account_params
    params.require(:account).permit(:name, :contact_mail)
  end
end
