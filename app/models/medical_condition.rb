class MedicalCondition < ActiveRecord::Base
  has_many   :child_medical_conditions
  has_many   :medical_conditions, :through => :child_medical_conditions
end
