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

  def navigation_link_to(name, options = {}, html_options = {}, &block)
    active = options.include?(controller_name) ||
      (home_controller? && options == '/') ||
      (settings_controller? && options =~ /settings/)

    link_to_if(active, name, options, class: 'active') do
      link_to name, options, html_options, &block
    end
  end

  def home_controller?
    controller_name == 'dashboard'
  end

  def settings_controller?
    request.path =~ /settings/
  end

  def city_options(cities, selected: nil)
    options_for_select(cities.map { |city| [city.name, 'data-name' => {name: city.name}.to_json] }, selected: selected)
  end
end
