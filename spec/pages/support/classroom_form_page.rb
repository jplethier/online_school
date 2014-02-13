class ClassroomFormPage < Page
  element :save_button, "button[name='commit']"

  def fill_mandatory_fields
    self.find('.teacher .selectize-input input').click
    self.find(".teacher div.option:first-child").click
    self.find('.subject .selectize-input input').click
    self.find(".subject div.option:first-child").click
  end

  def choose_subject(subject)
    self.find('.subject .selectize-input input').click
    self.find(".subject div.option[data-value='#{subject.id}']").click
  end

  def subject=(subject_name)
    select subject_name, from: 'classroom_subject_id'
  end

  def add_group(group)
    self.find('.select .selectize-input input').click
    self.find(".select div.option[data-value='#{group.id}']").click
  end

  def remove_group(group)
    self.find(:xpath, "//div[@class='list']/ul/li[contains(., '#{group.name}')]").hover
    self.find(:xpath, "//div[@class='list']/ul/li[contains(., '#{group.name}')]/a[@class='remove-fields']").click
  end

  def save
    self.save_button.click
  end
end
