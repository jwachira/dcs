module JavascriptHelper
  def javascript_tag(filename)
    content_for(:javascript_tag, javascript_include_tag(filename))
  end
end