class RegistrationsController < Devise::RegistrationsController

  protected

  def build_resource(hash=nil)
    if params[:user]
      params[:user].permit!
      self.resource = User.new(params[:user])
      self.resource.account.name = self.resource.name
    else
      self.resource = User.new
    end
    self.resource
  end
end
