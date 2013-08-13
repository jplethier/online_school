class StudentsController < AuthorizedController
  load_and_authorize_resource class: 'User'
  before_filter :populate_cities_and_states, only: [:new, :edit]
  before_filter :populate_groups, only: [:new, :edit]

  prepend_before_filter do
    params[:user] &&= student_params
  end

  def index
    @students = @students.students.ordered_by_name
    @students = @students.search(params[:search]) if params[:search].present?
  end

  def new
    @student.student = true
  end

  def create
    @student.student = true
    @student.skip_confirmation!

    if @student.save
      redirect_to students_path, success: 'Aluno criado com sucesso'
    else
      flash[:error] = 'Não foi possível criar um aluno'
      populate_cities_and_states && populate_groups && render(:new)
    end
  end

  def edit
  end

  def update
    if @student.update_attributes(student_params)
      redirect_to students_path, success: 'Dados do aluno atualizado com sucesso.'
    else
      flash.now[:error] = 'Não foi possível atualizar os dados do aluno.'
      populate_cities_and_states && populate_groups && render(:edit)
    end
  end

  private

  def student_params
    params[:user].delete :avatar if params[:user][:avatar].blank?

    params.require(:user).permit(:address, :address_city, :address_complement, :address_number, :address_state, :avatar, :avatar_delete, :birth_date, :cellphone_number, :email, :name, :enrollment, :password, :password_confirmation, :phone_number, group_ids: [])
  end

  def populate_cities_and_states
    @states = City.order(:uf).select(:uf).uniq.collect { |city| [city.uf] }

    if @student.address_state?
      @cities = City.select(:name).find_by_uf(@student.address_state).collect { |city| [city.name] }
    else
      @cities = []
    end
  end

  def populate_groups
    @groups = current_account.groups.collect { |group| [group.name, group.id] }
  end
end
