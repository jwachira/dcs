class ChildImmunization < ApplicationModel
  belongs_to :child
  belongs_to :immunization
  
  validates_uniqueness_of :immunization_id, :scope => :child_id
  
  def self.upcoming
    scoped(:conditions => ["next_dose_date >= ?", Date.today])
  end
   
end
