class Guardian < ApplicationModel
  belongs_to :family
  
  has_attached_file :photo
  
  validates_presence_of :first_name, :last_name, :street_address, :city, :postal_code, :state
  validates_presence_of :primary_phone_number, :relationship_to_child
    
  RELATIONSHIPS_TO_CHILD = ["Mother","Father","Guardian","Foster Parent","Relative", "Family Friend", "Other"]
end
