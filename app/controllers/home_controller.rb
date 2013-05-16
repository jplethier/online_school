class HomeController < ApplicationController
  def contact_form
    render layout: false
  end

  def contact_email
    if params[:name].blank? || params[:email].blank? || params[:subject].blank? || params[:message].blank?
      flash[:error] = I18n.t('faq.all_fields_should_be_filled')
      render 'faq'
    else
      FaqMailer.contact_us(params[:name], params[:email], params[:subject], params[:message].html_safe).deliver
      redirect_to cv_faq_path, :alert => I18n.t('faq.message_sent')
    end
  end
end