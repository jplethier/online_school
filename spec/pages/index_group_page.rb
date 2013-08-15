class GroupSection < SitePrism::Section
end

class IndexGroupPage < Page
  set_url "http://{subdomain}.lvh.me:31234/groups"

  element :search_field,  ".search-wrapper input[name='search']"
  element :search_button, ".search-wrapper button[type='submit']"

  sections :groups, GroupSection, '.collection tbody tr'

  def search(query)
    self.search_field.set query
    self.search_button.click
  end
end

