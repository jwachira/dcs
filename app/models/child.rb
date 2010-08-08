class Child < ActiveRecord::Base
  belongs_to :family
  belongs_to :provider
  has_many   :emergency_contacts
  has_many   :child_immunizations
  has_many   :immunizations, :through => :child_immunizations
end
