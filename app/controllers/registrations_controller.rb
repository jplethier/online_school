class RegistrationsController < Devise::RegistrationsController

  protected

  def build_resource(hash=nil)
    params.require(:user).permit(:email)
    params.require(:user).require(:account).permit(account: [:name])

    self.resource = User.new params[:user]
    self.resource.account.name = params[:user][:account][:name]
    self.resource
  end
end
