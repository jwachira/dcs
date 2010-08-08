class Certification < ActiveRecord::Base
  has_many :teacher_certifications
  has_many :teacher, :through => :teacher_certifications
end
