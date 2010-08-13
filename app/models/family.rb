class Family < ActiveRecord::Base
  has_many   :children
  has_many   :guardians
  belongs_to :provider
  has_many   :emergency_contacts
  
  attr_protected :provider
  
  accepts_nested_attributes_for :children
  accepts_nested_attributes_for :guardians
  
  def full_name
    "#{first_name} #{last_name}"
  end
  
  def add_children_to_waiting_list
    self.children.each do |child|
      if child.enrollment_status.nil?
        child.enrollment_status = "on_waiting_list"
      end
    end
  end
  
end
