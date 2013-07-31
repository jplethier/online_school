class GroupsController < AuthorizedController
  load_and_authorize_resource

  prepend_before_filter do
    params[:group] &&= group_params
  end

  def create
    if @group.save
      redirect_to groups_path, success: 'Classe criada com sucesso'
    else
      flash.now[:error] = 'Não foi possível criar uma classe'
      render :new
    end
  end

  def update
    if @group.update_attributes(group_params)
      redirect_to groups_path, success: 'Dados da classe atualizados com sucesso.'
    else
      flash.now[:error] = 'Não foi possível atualizar os dados da classe.'
      render :edit
    end
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end
end
