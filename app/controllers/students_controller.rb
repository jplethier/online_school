class StudentsController < AuthorizedController
  load_and_authorize_resource class: 'User'
  before_filter :populate_cities_and_states, only: [:new, :edit]

  prepend_before_filter do
   params[:user] &&= student_params
 end

  def index
    @students = @students.students
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
      populate_cities_and_states && render(:new)
    end
  end

  def edit
  end

  def update
    if @student.update_attributes(student_params)
      redirect_to students_path, notice: 'Dados do aluno atualizado com sucesso.'
    else
      flash.now[:error] = 'Não foi possível atualizar os dados do aluno.'
      populate_cities_and_states && render(:edit)
    end
  end

  private

  def student_params
    params.require(:user).permit(:address, :address_city, :address_complement, :address_number, :address_state, :avatar, :birth_date, :cellphone_number, :email, :name, :enrollment, :password, :password_confirmation, :phone_number)
  end

  def populate_cities_and_states
    @states = City.order(:uf).select(:uf).uniq.collect { |city| [city.uf] }

    if @student.address_state?
      @cities = City.select(:name).find_by_uf(@student.address_state).collect { |city| [city.name] }
    else
      @cities = []
    end
  end
end
