class ChildImmunization < ActiveRecord::Base
  belongs_to :child
  belongs_to :immunization
end
