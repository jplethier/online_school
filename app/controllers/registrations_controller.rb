class RegistrationsController < Devise::RegistrationsController
  protected

  def build_resource(hash=nil)
    if params[:user].blank?
      self.resource = User.new
    else
      self.resource = User.new sign_up_params
      self.resource.admin = true
      unless params[:user][:account_attributes][:name].blank?
        self.resource.name = 'Admin ' + params[:user][:account_attributes][:name]
      end
    end
    self.resource
  end
end
