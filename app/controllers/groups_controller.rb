class GroupsController < AuthorizedController
  load_and_authorize_resource
  before_filter :populate_students, only: [:new, :edit]

  prepend_before_filter do
    params[:group] &&= group_params
  end

  def index
    @groups = @groups.page(params[:page])
    @groups = @groups.search(params[:search]) if params[:search].present?
  end

  def create
    if @group.save
      redirect_to groups_path, success: 'Classe criada com sucesso'
    else
      flash.now[:error] = 'Não foi possível criar uma classe'
      populate_students && render(:new)
    end
  end

  def update
    if @group.update_attributes(group_params)
      redirect_to groups_path, success: 'Dados da classe atualizados com sucesso.'
    else
      flash.now[:error] = 'Não foi possível atualizar os dados da classe.'
      populate_students && render(:edit)
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, user_groups_attributes: [:id, :user_id, :_destroy])
  end

  def populate_students
    @students = current_account.users.students
  end
end
