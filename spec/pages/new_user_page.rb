class NewUserPage < Page
  set_url "/users/sign_up?plan_id={plan_id}"

  element :account_name_field,          "article input[name='user[account_attributes][name]']"
  element :account_contact_mail_field,  "article input[name='user[account_attributes][contact_mail]']"
  element :account_subdomain_field,     "article input[name='user[account_attributes][subdomain]']"
  element :email_field,                 "article input[name='user[email]']"
  element :password_field,              "article input[name='user[password]']"
  element :password_confirmation_field, "article input[name='user[password_confirmation]']"
  element :create_button,               "article input[name='commit']"

  def fill_mandatory_fields
    self.account_name          = 'Mandatory account name'
    self.account_contact_mail  = 'mandatory@example.com'
    self.account_subdomain     = 'mandatory'
    self.email                 = 'mandatory@example.com'
    self.password              = '1234qwer'
    self.password_confirmation = '1234qwer'
  end

  def create
    self.create_button.click
  end

  def account_name=(name)
    self.account_name_field.set name
  end

  def account_contact_mail=(email)
    self.account_contact_mail_field.set email
  end

  def account_subdomain=(subdomain)
    self.account_subdomain_field.set subdomain
  end

  def email=(email)
    self.email_field.set email
  end

  def password=(password)
    self.password_field.set password
  end

  def password_confirmation=(password)
    self.password_confirmation_field.set password
  end
end
