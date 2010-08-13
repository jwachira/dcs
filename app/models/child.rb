class Child < ApplicationModel
  belongs_to :family
  belongs_to :provider
  
  has_many   :emergency_contacts
  has_many   :child_immunizations
  has_many   :immunizations, :through => :child_immunizations
  
  validates_presence_of :first_name, :last_name, :gender, :date_of_birth
  validates_presence_of :requires_special_care

end
