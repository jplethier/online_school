class StudentsController < ApplicationController

  def index
    @students = User.students
  end

  def new
    @student = User.new(student: true)
  end

  def create
    @student = User.new(params.require(:user).permit(:address, :address_city, :address_complement, :address_number, :address_state, :birth_date, :cellphone_number, :email, :name, :enrollment, :password, :password_cofirmation, :phone_number))
    @student.student = true
    if @student.save
      redirect_to students_path, success: 'Aluno criado com sucesso'
    else
      flash[:error] = 'Não foi possível criar um aluno'
      render :new
    end
  end
end
