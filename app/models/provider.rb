class Provider < ApplicationModel
  belongs_to :user
  has_many :children
  has_many :teachers
  has_many :provider_contacts
  
  attr_protected :user
  # attr_accessible :name, :street_address, :city, :postal_code, :state, :phone_number, :secondary_phone_number,
  #                 :li
  
  validates_presence_of :user
  validates_presence_of :name, :street_address, :city, :postal_code, :state, :phone_number
end
