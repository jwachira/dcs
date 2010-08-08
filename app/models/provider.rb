class Provider < ActiveRecord::Base
  has_many :children
  has_many :teachers
  has_many :provider_contacts
end
