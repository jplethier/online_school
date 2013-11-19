#coding: utf-8
class ExamsController < ApplicationController
  load_and_authorize_resource

  prepend_before_filter do
    params[:exam] &&= exam_params
  end

  def new
    @exam.classroom = Classroom.find(params[:classroom_id])
  end

  def create
    classroom = Classroom.find(params[:classroom_id])
    @exam.classroom = classroom
    if @exam.save
      redirect_to classroom_path(classroom), success: 'Avaliação criada com sucesso.'
    else
      flash.now[:error] = 'Não foi possível criar a avaliação'
      render :new
    end
  end

  def update
    if @exam.update_attributes(exam_params)
      redirect_to classroom_path(@exam.classroom), success: 'Dados da avaliação atualizados com sucesso.'
    else
      flash.now[:error] = 'Não foi possível atualizar os dados da avaliação.'
      render :edit
    end
  end

  protected

  def exam_params
    params.require(:exam).permit(:exam_date, :kind, :period)
  end
end
