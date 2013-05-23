class NewTeacher < SitePrism::Page
  set_url "http://{subdomain}.lvh.me:3000/teachers/new"

  element :email,                 "input[name='user[email]']"
  element :name,                  "input[name='user[name]']"
  element :password,              "input[name='user[password]']"
  element :password_confirmation, "input[name='user[password_confirmation]']"
  element :create_button,         "input[name='commit'].primary"

  def self.visit(hash)
    page = self.new
    page.load(hash)
    page
  end

  def create
    self.create_button.click
  end

  def email=(email)
    self.email.set email
  end

  def name=(name)
    self.name.set name
  end

  def password=(password)
    self.password.set password
  end

  def password_confirmation=(password)
    self.password_confirmation.set password
  end
end
