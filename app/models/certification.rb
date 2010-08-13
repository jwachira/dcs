class Certification < ActiveRecord::Base
  has_many :teacher_certifications
  has_many :teacher, :through => :teacher_certifications
  
  validates_presence_of   :name
  validates_uniqueness_of :name
end
