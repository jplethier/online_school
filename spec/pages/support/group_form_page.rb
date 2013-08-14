class GroupFormPage < Page
  element :name_field,    "input[name='group[name]']"
  element :create_button, "button[name='commit']"

  def fill_mandatory_fields
    self.name = 'Mandatory name'
  end

  def add_student(student)
    self.find('.selectize-input input').click
    self.find("div.option[data-value='#{student.id}']").click
  end

  def remove_student(student)
    self.find('.students-list ul li:first-child .remove-fields').click
    # self.find(:xpath, "//div[@class='students-list']/ul/li[contains('#{student.name}')]").find('.remove-fields').click
  end

  def create
    self.create_button.click
  end

  def name=(name)
    self.name_field.set name
  end
end
