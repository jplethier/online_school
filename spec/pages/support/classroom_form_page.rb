class ClassroomFormPage < Page
  element :save_button,   "button[name='commit']"

  def fill_mandatory_fields
    self.find('.teacher .selectize-input input').click
    self.find(".teacher div.option:first-child").click
    self.find('.subject .selectize-input input').click
    self.find(".subject div.option:first-child").click
  end

  def add_group(group)
    self.find('.students-select .selectize-input input').click
    self.find(".students-select div.option[data-value='#{group.id}']").click
  end

  def remove_group(group)
    self.find(:xpath, "//div[@class='students-list']/ul/li[contains(., '#{group.name}')]").hover
    self.find(:xpath, "//div[@class='students-list']/ul/li[contains(., '#{group.name}')]/a[@class='remove-fields']").click
  end

  def save
    self.save_button.click
  end
end
