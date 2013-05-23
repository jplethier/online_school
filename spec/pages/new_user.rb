class NewUser < SitePrism::Page
  set_url "/users/sign_up"

  element :account_name,          "article input[name='user[account_attributes][name]']"
  element :account_subdomain,     "article input[name='user[account_attributes][subdomain]']"
  element :email,                 "article input[name='user[email]']"
  element :password,              "article input[name='user[password]']"
  element :password_confirmation, "article input[name='user[password_confirmation]']"
  element :create_button,         "article input[name='commit']"

  def self.visit
    self.new.tap { |page| page.load }
  end

  def create
    self.create_button.click
  end

  def account_name=(name)
    self.account_name.set name
  end

  def account_subdomain=(subdomain)
    self.account_subdomain.set subdomain
  end

  def email=(email)
    self.email.set email
  end

  def password=(password)
    self.password.set password
  end

  def password_confirmation=(password)
    self.password_confirmation.set password
  end
end
