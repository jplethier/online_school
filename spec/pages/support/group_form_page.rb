class GroupFormPage < Page
  element :name_field,    "input[name='group[name]']"
  element :create_button, "button[name='commit']"

  def create
    self.create_button.click
  end

  def name=(name)
    self.name_field.set name
  end
end
