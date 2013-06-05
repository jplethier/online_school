class StudentSection < SitePrism::Section
end

class IndexStudent < SitePrism::Page
  set_url "http://{subdomain}.lvh.me:3000/students"

  element :search_field,  "#student_search input[name='search']"
  element :search_button, "#student_search button[type='submit']"

  sections :students, StudentSection, '#students li'

  def self.visit(hash)
    page = self.new
    page.load(hash)
    page
  end

  def search(query)
    self.search_field.set query
    self.search_button.click
  end
end

