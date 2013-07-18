module ApplicationHelper
  def flash_messages
    flash.collect do |key, msg|
      content_tag :div, class: "message #{key}" do
        content_tag(:p, msg)
      end
    end.join.html_safe
  end

  def current_account
    if user_signed_in?
      current_user.account
    end
  end
end
