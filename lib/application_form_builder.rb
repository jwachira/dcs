class ApplicationFormBuilder < Formtastic::SemanticFormBuilder
  # Custom form builder methods go here
  
  def cancel_link(text = 'Cancel')
    template.link_to text, :back
  end
  
  def calendar_input(method, options)
    # don't want to use #{method}_before_type_cast; want to get the value after it has been formatted
    options[:value] ||= @object.send(method).try(:to_s, :mdy)
    label(method, options.delete(:label), options.slice(:required)) + text_field(method, options)
  end
end