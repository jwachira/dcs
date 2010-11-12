class Child < ApplicationModel
  belongs_to :family
  belongs_to :provider
  has_many   :child_medical_conditions
  has_many   :medical_conditions, :through => :child_medical_conditions
  has_many   :emergency_contacts
  has_many   :child_immunizations
  has_many   :immunizations, :through => :child_immunizations
  
  
  has_attached_file :photo
  
  after_save :populate_child_immunization_history #, :if => Proc.new{|child| child.new_record?}
  
  validates_presence_of :first_name, :last_name, :gender, :date_of_birth
  validates_presence_of :requires_special_care

 def self.on_waiting_lists
  scoped(:conditions => {:enrollment_status => "on_waiting_lists"})
 end
 
 def populate_child_immunization_history
   Child.transaction do
     Immunization.all.each do |immunization|
       child_immunization = ChildImmunization.new
       child_immunization.immunization = immunization
       child_immunization.child        = self
       child_immunization.active       = true
       child_immunization.save
     end
   end
 end
 
end
