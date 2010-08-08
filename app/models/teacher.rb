class Teacher < ActiveRecord::Base
  has_many :teacher_certifications
  has_many :certifications, :through => :teacher_certifications
  belongs_to :provider
end
