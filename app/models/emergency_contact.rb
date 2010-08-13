class EmergencyContact < ApplicationModel
  belongs_to :family
  validates_presence_of :first_name, :last_name, :primary_phone, :secondary_phone
end
