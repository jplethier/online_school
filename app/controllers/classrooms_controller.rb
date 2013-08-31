class ClassroomsController < AuthorizedController
  load_and_authorize_resource
  before_filter :populate_groups_subjects_and_teachers, only: [:new, :edit]

  prepend_before_filter :create_subject_when_subject_id_is_a_string, only: [:create, :update]

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
      populate_groups_subjects_and_teachers && render(:new)
    end
  end

  def update
    if @classroom.update_attributes(classroom_params)
      redirect_to classrooms_path, success: 'Dados da turma atualizados com sucesso.'
    else
      flash.now[:error] = 'Não foi possível atualizar os dados da turma.'
      populate_groups_subjects_and_teachers && render(:edit)
    end
  end

  private

  def classroom_params
    params.require(:classroom).permit(:subject_id, :teacher_id, entries_attributes: [:id, :resource_type, :resource_id, :_destroy])
  end

  def populate_groups_subjects_and_teachers
    @groups = current_account.groups
    @subjects = current_account.subjects
    @teachers = current_account.users.teachers
  end

  def create_subject_when_subject_id_is_a_string
    unless params[:classroom][:subject_id].is_number?
      params[:classroom][:subject_id] = current_account.subjects.find_or_create_by_name(params[:classroom][:subject_id]).id
    end
  end
end
