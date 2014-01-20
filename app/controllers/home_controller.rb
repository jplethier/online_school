class HomeController < ApplicationController
  layout 'home'

  def index
    @plans          = {}
    @plans[:small]  = Plan.where(title: 'Pequeno').first_or_create { |plan| plan.price = 100; plan.students_number = 100 }
    @plans[:medium] = Plan.where(title: 'Médio').first_or_create   { |plan| plan.price = 180; plan.students_number = 200 }
    @plans[:big]    = Plan.where(title: 'Grande').first_or_create  { |plan| plan.price = 500; plan.students_number = 400 }
  end

  def contact_form
    render layout: false
  end

  def send_contact_email
    FaqMailer.contact_us(params[:name], params[:email], params[:message], params[:plan]).deliver
    redirect_to root_path, success: 'Mensagem enviada com sucesso. Entraremos em contato em breve.'
  end
end
