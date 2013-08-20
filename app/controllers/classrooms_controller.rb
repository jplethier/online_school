class ClassroomsController < AuthorizedController
  load_and_authorize_resource
  before_filter :populate_groups, only: [:new, :edit]

  prepend_before_filter do
    params[:classroom] &&= classroom_params
  end

  def index
    @classrooms = @classrooms.ordered_by_name.page(params[:page])
    @classrooms = @classrooms.search(params[:search]) if params[:search].present?
  end

  def create
    if @classroom.save
      redirect_to classrooms_path, success: 'Turma criada com sucesso'
    else
      flash.now[:error] = 'Não foi possível criar uma turma'
      populate_groups && render(:new)
    end
  end

  def update
    if @classroom.update_attributes(classroom_params)
      redirect_to classrooms_path, success: 'Dados da turma atualizados com sucesso.'
    else
      flash.now[:error] = 'Não foi possível atualizar os dados da turma.'
      populate_groups && render(:edit)
    end
  end

  private

  def classroom_params
    params.require(:classroom).permit(:name, user_classrooms_attributes: [:id, :user_id, :_destroy])
  end

  def populate_groups
    @groups = current_user.account.groups
  end
end
