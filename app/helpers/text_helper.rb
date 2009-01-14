module TextHelper
  def snake_case(text)
    text.gsub(/\s+/, '_').downcase
  end
end