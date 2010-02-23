class User < ActiveRecord::Base
  acts_as_authentic
  model_stamper
  stampable
  
  ROLES = ['Admin','User']
  
  attr_protected :password
  validates_length_of :password, :minimum => 6, :allow_nil => true
  validates_format_of :password, :with => /[a-z]/i, :allow_nil => true, :message => "must include a letter"
  validates_format_of :password, :with => /[0-9]/, :allow_nil => true, :message => "must include a number"


  # The necessary method for the plugin to find out about the role symbols
  # Roles returns e.g. [:admin]
  
  def role_symbols
    @role_symbols ||= (!role.nil?) ? [role.downcase.to_sym] : []
  end

  # End of declarative_authorization code
    
  def full_name
    "#{first_name} #{last_name}"
  end

  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(self)
  end
  
end
