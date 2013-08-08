class LoginPage < Page
  set_url "http://{subdomain}.lvh.me:31234/users/sign_in"
  set_url_matcher(/users\/sign_in/)

  element :email_field,    "article input[name='user[email]']"
  element :password_field, "article input[name='user[password]']"
  element :sign_in_button, "article input[name='commit']"

  def sign_in
    sign_in_button.click
  end

  def email
    email_field.value
  end

  def email=(email)
    email_field.set email
  end

  def password=(password)
    password_field.set password
  end
end
