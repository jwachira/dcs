module LayoutHelper
  
  def title(text, options = {})
    options.symbolize_keys!

    content_for :title, text

    if options[:body] == true
     content_for :h1_tag, content_tag(:h1, text)
    end
  end
  
  def side_bar(partial, grantee = nil)
    content_for(:main_class, 'span-34')
    content_for(:side_bar, render(:partial => "navigation/sidebar/#{partial}", :locals => {:grantee => grantee }))
  end
end
