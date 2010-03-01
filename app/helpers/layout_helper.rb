module LayoutHelper
  def title(title)
    content_for(:title, title)
  end
  
  def side_bar(partial, grantee = nil)
    content_for(:main_class, 'span-34')
    content_for(:side_bar, render(:partial => "navigation/sidebar/#{partial}", :locals => {:grantee => grantee }))
  end
end
