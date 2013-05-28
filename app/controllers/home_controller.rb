class HomeController < ApplicationController
  layout 'home'

  def contact_form
    render layout: false
  end

  def send_contact_email
    FaqMailer.contact_us(params[:name], params[:email], params[:message], params[:plan]).deliver
    redirect_to root_path, success: 'Mensagem enviada com sucesso. Entraremos em contato em breve.'
  end
end
