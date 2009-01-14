module LinkHelper
  def button_link_to(text, location, options = {})
    options[:class] ||= ''
    options[:class] += ' button'
    link_to "<span>+</span> #{text}", location, options
  end
  
  def on_state_class(flag)
    flag ? 'on' : ''
  end
end