class ApplicationFormBuilder < Formtastic::SemanticFormBuilder
  # Custom form builder methods go here
  
  def cancel_link(options = {})
    location = options[:url] || template.request.params[:_cancel_url] || template.request.referer || '/'
    template.hidden_field_tag(:_cancel_url, location)
    
    if location =~ /\?/
      location = location + '&_cancel=1'
    else
      location = location + '?_cancel=1'
    end
    
    template.content_tag(:li, template.link_to('Cancel', location), :class => "cancel" )
  end
  
  def calendar_input(method, options)
    # don't want to use #{method}_before_type_cast; want to get the value after it has been formatted
    options[:value] ||= @object.send(method).try(:to_s, :mdy)
    label(method, options.delete(:label), options.slice(:required)) + text_field(method, options)
  end
end