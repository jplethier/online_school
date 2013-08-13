class TeachersController < AuthorizedController
  load_and_authorize_resource :class => "User"
  before_filter :populate_cities_and_states, only: [:new, :edit]

  prepend_before_filter do
    params[:user] &&= teacher_params
  end

  def index
    @teachers = @teachers.teachers.ordered_by_name
    @teachers = @teachers.search(params[:search]) if params[:search].present?
  end

  def new
    @teacher.teacher = true
  end

  def create
    @teacher.teacher = true
    @teacher.skip_confirmation!

    if @teacher.save
      redirect_to teachers_path, success: 'Professor criado com sucesso'
    else
      flash[:error] = 'Não foi possível criar um professor'
      populate_cities_and_states && render(:new)
    end
  end

  def edit
  end

  def update
    if @teacher.update_attributes(teacher_params)
      redirect_to teachers_path, success: 'Dados do professor atualizados com sucesso.'
    else
      flash.now[:error] = 'Não foi possível atualizar os dados do professor.'
      populate_cities_and_states && render(:edit)
    end
  end

  private

  def teacher_params
    params[:user].delete :avatar if params[:user][:avatar].blank?

    params.require(:user).permit(:address, :address_city, :address_complement, :address_number, :address_state, :avatar, :avatar_delete, :birth_date, :cellphone_number, :email, :name, :enrollment, :password, :password_confirmation, :phone_number)
  end

  def populate_cities_and_states
    @states = City.order(:uf).select(:uf).uniq.collect { |city| [city.uf] }

    if @teacher.address_state?
      @cities = City.select(:name).find_by_uf(@teacher.address_state).collect { |city| [city.name] }
    else
      @cities = []
    end
  end
end
