class ChildMedicalCondition < ActiveRecord::Base
  belongs_to :child
  belongs_to :medical_condition
end
