class ClassroomsController < AuthorizedController
  load_and_authorize_resource
  before_filter :populate_groups_subjects_and_teachers, only: [:new, :edit]
  before_filter :populate_classroom_groups, only: [:edit]

  prepend_before_filter do
    params[:classroom] &&= classroom_params
  end

  prepend_before_filter :create_subject_when_subject_id_is_a_string, only: [:create, :update]
  prepend_before_filter :parse_group_ids, only: [:create, :update]

  def index
    if @classrooms.blank?
      @classrooms = current_user.classrooms.where(account_id: current_user.account_id)
    end
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

  def show
    @past_exams = @classroom.exams.past
    @future_exams = @classroom.exams.future
  end

  private

  def classroom_params
    params.require(:classroom).permit(:subject_id, :teacher_id, temporary_group_ids: [])
  end

  def populate_classroom_groups
    @classroom_groups = @classroom.groups
  end

  def populate_groups_subjects_and_teachers
    @groups   = current_account.groups
    @subjects = current_account.subjects
    @teachers = current_account.users.teachers
  end

  def create_subject_when_subject_id_is_a_string
    unless params[:classroom][:subject_id].is_number?
      params[:classroom][:subject_id] = current_account.subjects.find_or_create_by(name: params[:classroom][:subject_id]).id
    end
  end

  def parse_group_ids
    if params[:classroom][:temporary_group_ids]
      params[:classroom][:temporary_group_ids] = params[:classroom][:temporary_group_ids].map(&:to_i)
    else
      params[:classroom][:temporary_group_ids] = []
    end
  end
end
