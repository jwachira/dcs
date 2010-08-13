class Immunization < ActiveRecord::Base
  has_many :child_immunizations
  has_many :children, :through => :child_immunizations
  
  validates_presence_of :name
end
