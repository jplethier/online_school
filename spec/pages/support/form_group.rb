class FormGroup < SitePrism::Page
  element :name_field,    "input[name='group[name]']"
  element :create_button, "button[name='commit']"

  def self.visit(hash)
    page = self.new
    page.load(hash)
    page
  end

  def create
    self.create_button.click
  end

  def name=(name)
    self.name_field.set name
  end
end
