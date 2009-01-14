module InstructionHelper
  def password_instructions
    '<li class="indentLabelWidth">Passwords must be at least 6 characters in length and include at least one number and one letter.</li>'
  end
  
  def link_to_instruction(text, instruction_name, options = {})
    options[:class] ||= ''
    options[:class] += ' help'
    options[:popup] ||= {}
    options[:popup].reverse_merge!(:height => 400, :width => 400)
    link_to_popup(text, instruction_path(instruction_name), options)
  end
end