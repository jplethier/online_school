class TeacherSection < SitePrism::Section
end

class IndexTeacherPage < Page
  set_url "http://{subdomain}.lvh.me:31234/teachers"

  element :search_field,  ".search-wrapper input[name='search']"
  element :search_button, ".search-wrapper button[type='submit']"

  sections :teachers, TeacherSection, '.collection li'

  def search(query)
    self.search_field.set query
    self.search_button.click
  end
end

