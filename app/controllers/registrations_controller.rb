class RegistrationsController < Devise::RegistrationsController
  protected

  def build_resource(hash=nil)
    if hash.blank?
      self.resource = User.new
    else
      assign_contact_mail hash

      self.resource = User.new hash
      self.resource.admin = true

      unless hash[:account_attributes][:name].blank?
        self.resource.name = 'Admin ' + hash[:account_attributes][:name]
      end
    end

    self.resource
  end

  private

  def assign_contact_mail(hash)
    hash[:account_attributes][:contact_mail] = hash[:email]
  end
end
