class NewStudentsImportPage < Page
  set_url "http://{subdomain}.lvh.me:31234/settings/data_imports/new"

  element :import_button, "button[name='commit']"

  def file=(file)
    attach_file('data_import_file', file)
  end

  def import
    self.import_button.click
  end
end
