class StudentSection < SitePrism::Section
end

class IndexStudentPage < Page
  set_url "http://{subdomain}.lvh.me:31234/students"

  element :search_field,  "#student_search input[name='search']"
  element :search_button, "#student_search button[type='submit']"

  sections :students, StudentSection, '#students li'

  def search(query)
    self.search_field.set query
    self.search_button.click
  end
end

