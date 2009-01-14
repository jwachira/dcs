module PopupHelper
  # Creates the neccessary link and javascript block needed to pass custom parameters to
  # our jquery popup script. 
  # See http://www.djsipe.com/2008/07/04/doing-pop-ups-the-right-way-with-jquery/
  # for details.
  def link_to_popup(link_text, url, *args)
    html_options  = args.first || {}
    
    html_options[:class] ||= ''
    html_options[:class] += ' popup'
    
    popup_options = html_options.delete(:popup)
    
    if html_options[:id].nil? && !popup_options.nil?
      html_options = html_options.merge(:id => rand(100000))
    end
    
    #raise html_options.inspect
  
    html = link_to( link_text, url, html_options)
    if !popup_options.blank?
      html += "\n"
      html += "<script type='text/javascript'> \n"
      html +=   "$('a##{html_options[:id]}').data('popup', #{popup_options.to_json}); \n"
      html += "</script> \n"
    end
    return html
  end
end