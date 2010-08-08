class Immunization < ActiveRecord::Base
  has_many :child_immunizations
  has_many :children, :through => :child_immunizations
end
