class EmployeesController < AuthorizedController
  load_and_authorize_resource :class => "User"
  before_filter :populate_cities_and_states, only: [:new, :edit]

  prepend_before_filter do
    params[:user] &&= employee_params
  end

  def index
    @employees = @employees.employees.ordered_by_name
    @employees = @employees.search(params[:search]) if params[:search].present?
  end

  def new
    @employee.employee = true
  end

  def create
    @employee.employee = true
    @employee.skip_confirmation!

    if @employee.save
      redirect_to employees_path, success: 'Funcionário criado com sucesso'
    else
      flash[:error] = 'Não foi possível criar um funcionário'
      populate_cities_and_states && render(:new)
    end
  end

  def edit
  end

  def update
    if @employee.update_attributes(employee_params)
      redirect_to employees_path, success: 'Dados do funcionário atualizados com sucesso.'
    else
      flash.now[:error] = 'Não foi possível atualizar os dados do funcionário.'
      populate_cities_and_states && render(:edit)
    end
  end

  private

  def employee_params
    params[:user].delete :avatar if params[:user][:avatar].blank?

    params.require(:user).permit(:address, :address_city, :address_complement, :address_number, :address_state, :avatar, :avatar_delete, :birth_date, :cellphone_number, :email, :name, :enrollment, :password, :password_confirmation, :phone_number)
  end

  def populate_cities_and_states
    @states = City.order(:uf).select(:uf).uniq.collect(&:uf)

    if @employee.address_state?
      @cities = City.select(:name).find_by_uf(@employee.address_state).collect(&:name)
    else
      @cities = []
    end
  end
end
