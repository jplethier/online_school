class HomePage < Page
  set_url '/'
  set_url_matcher(/.com\/$/)

  element :email_field,    ".nav input[name='email']"
  element :sign_in_button, ".nav input[type='submit']"

  def sign_in
    self.sign_in_button.click
    LoginPage.new
  end

  def email=(email)
    self.email_field.set email
  end
end
