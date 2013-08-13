class EditTeacherPage < TeacherFormPage
  set_url "http://{subdomain}.lvh.me:31234/teachers/{id}/edit"

  element :remove_avatar_checkbox, '#user_avatar_delete'

  def remove_avatar
    self.remove_avatar_checkbox.set '1'
  end
end
