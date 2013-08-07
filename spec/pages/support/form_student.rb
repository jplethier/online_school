class FormStudent < SitePrism::Page
  element :save_button,                 "button[name='commit']"
  element :remove_avatar_button,        ".destroy.fileupload-exists"

  element :email_field,                 "input[name='user[email]']"
  element :enrollment_field,            "input[name='user[enrollment]']"
  element :name_field,                  "input[name='user[name]']"
  element :password_field,              "input[name='user[password]']"
  element :password_confirmation_field, "input[name='user[password_confirmation]']"

  def self.visit(hash)
    page = self.new
    page.load(hash)
    page
  end

  def remove_avatar
    self.remove_avatar_button.click
  end

  def save
    self.save_button.click
  end

  def email=(email)
    self.email_field.set email
  end

  def enrollment=(enrollment)
    self.enrollment_field.set enrollment
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

  def avatar=(image_file)
    attach_file('user_avatar', image_file)
  end
end
