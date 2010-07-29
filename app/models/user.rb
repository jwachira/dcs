=begin Schema Information

 Table name: users

  id                :integer(4)      not null, primary key
  first_name        :string(255)
  last_name         :string(255)
  crypted_password  :string(255)
  password_salt     :string(255)
  persistence_token :string(255)
  perishable_token  :string(255)
  login_count       :integer(4)      default(0), not null
  email             :string(255)     default(""), not null
  role              :string(20)
  last_request_at   :datetime
  last_login_at     :datetime
  current_login_at  :string(255)
  last_login_ip     :string(255)
  current_login_ip  :string(255)
  creator_id        :integer(4)
  updater_id        :integer(4)
  created_at        :datetime
  updated_at        :datetime

=end Schema Information

class User < ApplicationModel
  
  belongs_to :property_group
  
  ROLES = ['Admin','Site Manager', 'Property Group Manager', 'Maintainance Man', 'Tenant']
  
  acts_as_authentic do |c|
    c.validate_password_field = false
  end
  
  model_stamper
  stampable
  
  attr_protected :password, :password_confirmation, :role
  
  validates_presence_of :first_name, :last_name, :email, :role
  attr_accessor :current_password
  attr_protected :password
  validates_confirmation_of :password
  validates_length_of :password, :minimum => 6, :allow_nil => true
  validates_format_of :password, :with => /[a-z]/i, :allow_nil => true, :message => "must include a letter"
  validates_format_of :password, :with => /[0-9]/, :allow_nil => true, :message => "must include a number"

  
  # This method is necessary method for declarative_authorization to determine roles
  # Roles returns e.g. [:admin]
  def role_symbols
    @role_symbols ||= (!role.nil?) ? [role.downcase.to_sym] : []
  end
    
  def full_name
    "#{first_name} #{last_name}"
  end

  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(self)
  end
  
end
