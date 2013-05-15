class TeachersController < AuthorizedController
  load_and_authorize_resource :class => "User"

  prepend_before_filter do
   params[:user] &&= teacher_params
 end

  def index
    @teachers = @teachers.teachers
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
      render :new
    end
  end

  private

  def teacher_params
    params.require(:user).permit(:address, :address_city, :address_complement, :address_number, :address_state, :birth_date, :cellphone_number, :email, :name, :enrollment, :password, :password_confirmation, :phone_number)
  end
end
