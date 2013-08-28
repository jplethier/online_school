class ClassroomsController < AuthorizedController
  load_and_authorize_resource
  before_filter :populate_groups, only: [:new, :edit]
  before_filter :check_subject_id, only: [:create, :update]

  prepend_before_filter do
    params[:classroom] &&= classroom_params
  end

  def index
    @classrooms = @classrooms.page(params[:page])
    # @classrooms = @classrooms.search(params[:search]) if params[:search].present?
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
    params.require(:classroom).permit(:subject_id, :teacher_id, entries_attributes: [:id, :resource_type, :resource_id, :_destroy])
  end

  def populate_groups
    @groups = current_account.groups
  end

  def check_subject_id
    unless params[:classroom][:subject_id].is_number?
      @classroom.subject = current_account.subjects.find_or_create_by_name(params[:classroom][:subject_id])
    end
  end
end
