class RegistrationsController < Devise::RegistrationsController

  protected

  def build_resource(hash=nil)
    params.require(:user).permit(:email)
    params.require(:user).require(:account).permit(account: [:name])

    self.resource = User.new params[:user]
    unless params[:user][:account][:name].blank?
      self.resource.name = 'Admin ' + params[:user][:account][:name]
    end
    self.resource
  end
end
