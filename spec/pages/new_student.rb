class NewStudent < SitePrism::Page
  set_url "http://{subdomain}.lvh.me:3000/students/new"

  element :email_field,                 "input[name='user[email]']"
  element :name_field,                  "input[name='user[name]']"
  element :password_field,              "input[name='user[password]']"
  element :password_confirmation_field, "input[name='user[password_confirmation]']"
  element :create_button,               "button[name='commit']"

  def self.visit(hash)
    page = self.new
    page.load(hash)
    page
  end

  def create
    self.create_button.click
  end

  def email=(email)
    self.email_field.set email
  end

  def name=(name)
    self.name_field.set name
  end

  def password=(password)
    self.password_field.set password
  end

  def password_confirmation=(password)
    self.password_confirmation_field.set password
  end
end
