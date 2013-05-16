class FaqMailer < ActionMailer::Base

  default :from => "contato@minhasaladeaula.com"

  def contact_us(from_name, from_email, message, plan_name)
    @message = {from_name: from_name, from_email: from_email, message: message, plan_name: plan_name}
    mail to: 'contato@minhasaladeaula.com', subject: "Contato", body: @message, content_type: "text/html"
  end
end
