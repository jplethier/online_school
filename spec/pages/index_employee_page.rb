class EmployeeSection < SitePrism::Section
end

class IndexEmployeePage < Page
  set_url "http://{subdomain}.lvh.me:31234/employees"

  element :search_field,  ".search-wrapper input[name='search']"
  element :search_button, ".search-wrapper button[type='submit']"

  sections :employees, EmployeeSection, '.collection li'

  def search(query)
    self.search_field.set query
    self.search_button.click
  end
end

