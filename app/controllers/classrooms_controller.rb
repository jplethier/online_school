class ClassroomsController < AuthorizedController
  load_and_authorize_resource
  before_filter :populate_groups_subjects_and_teachers, only: [:new, :edit]
  before_filter :populate_classroom_groups, only: [:edit]

  prepend_before_filter :create_subject_when_subject_id_is_a_string, only: [:create, :update]

  prepend_before_filter do
    params[:classroom] &&= classroom_params
  end

  def index
    unless @classrooms.blank?
      @classrooms = @classrooms.ordered_by_name.page(params[:page])
      @classrooms = @classrooms.search(params[:search]) if params[:search].present?
    end
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
    params.require(:classroom).permit(:subject_id, :teacher_id, entries_attributes: [:id, :resource_id, :_destroy])
  end

  def populate_classroom_groups
    @classroom_groups = @classroom.groups.where(id: @classroom.group_ids)
  end

  def populate_groups_subjects_and_teachers
    @groups   = current_account.groups
    @subjects = current_account.subjects
    @teachers = current_account.users.teachers
  end

  #def assign_all_students_of_a_group
    #if classroom = params[:classroom]
      #classroom[:entries_attributes].values.each do |entry|
        #group = Group.find entry.delete(:resource_id)
        #group.students.map(&:user_id)
      #end
    #end
  #end

  def create_subject_when_subject_id_is_a_string
    unless params[:classroom][:subject_id].is_number?
      params[:classroom][:subject_id] = current_account.subjects.find_or_create_by(name: params[:classroom][:subject_id]).id
    end
  end
end
