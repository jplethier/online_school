class Login < SitePrism::Page
  set_url "http://{subdomain}.lvh.me:3000/users/sign_in"

  element :email, "article input[name='user[email]']"
  element :password, "article input[name='user[password]']"
  element :sign_in_button, "article input[name='commit']"

  def self.visit(hash)
    page = self.new
    page.load(hash)
    page
  end

  def sign_in
    self.sign_in_button.click
  end

  def email=(email)
    self.email.set email
  end

  def password=(password)
    self.password.set password
  end
end
