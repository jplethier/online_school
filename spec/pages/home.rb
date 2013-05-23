class Home < SitePrism::Page
  set_url '/'
  set_url_matcher(/.com\/$/)

  element :email_field,    ".nav input[name='email']"
  element :sign_in_button, ".nav input[type='submit']"

  def sign_in
    self.sign_in_button.click
    Login.new
  end

  def email=(email)
    self.email_field.set email
  end

  def self.visit
    self.new.tap { |page| page.load }
  end
end
