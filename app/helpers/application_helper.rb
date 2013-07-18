module ApplicationHelper
  def flash_messages
    flash.collect do |key, msg|
      content_tag :div, class: "message #{key}" do
        content_tag(:p, msg)
      end
    end.join.html_safe
  end

  def current_account
    current_user.account if user_signed_in?
  end

  def missing_avatar(style)
    "/users/avatars/#{style}/missing.png"
  end
end
