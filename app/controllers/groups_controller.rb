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

  private

  def group_params
    params.require(:group).permit(:name)
  end
end
