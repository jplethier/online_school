class HomeController < ApplicationController
  def contact_form
    render layout: false
  end

  def send_contact_email
    FaqMailer.contact_us(params[:name], params[:email], params[:message], params[:plan]).deliver
    redirect_to root_path, alert: 'Mensagem enviada com sucesso. Entraremos em contato em breve.'
  end
end