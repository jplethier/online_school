class StudentsController < AuthorizedController
  load_and_authorize_resource :class => "User"

  prepend_before_filter do
   params[:user] &&= student_params
 end

  def index
    @students = @students.students
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
      render :new
    end
  end

  def edit

  end

  def update
    if @student.update_attributes(student_params)
      redirect_to students_path, notice: 'Dados do aluno atualizado com sucesso.'
    else
      flash.now[:error] = 'Não foi possível atualizar os dados do aluno.'
      render :edit
    end
  end

  private

  def student_params
    params.require(:user).permit(:address, :address_city, :address_complement, :address_number, :address_state, :birth_date, :cellphone_number, :email, :name, :enrollment, :password, :password_confirmation, :phone_number)
  end
end
