class RegistrationsController < Devise::RegistrationsController
  def new
    @plans = Plan.order_by_price
    super
  end

  protected

  def build_resource(hash=nil)
    if hash.blank?
      self.resource = User.new
    else
      self.resource = User.new hash
      self.resource.admin = true

      unless hash[:account_attributes][:name].blank?
        self.resource.name = 'Admin ' + hash[:account_attributes][:name]
      end
    end

    self.resource
  end
end
