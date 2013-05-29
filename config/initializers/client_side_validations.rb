# Uncomment the following block if you want each input field to have the validation messages attached.
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  element = Ox.parse html_tag.gsub("'", '"')
  element[:class] = "#{element[:class]} error"

  unless html_tag =~ /^<label/
    div = Ox::Element.new('div')
    div[:class] = 'error'
    div.nodes << instance.error_message.first

    element.nodes << div
  end

  Ox.dump(element).force_encoding('UTF-8').html_safe
end
