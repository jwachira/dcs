class Teacher < ApplicationModel
  has_attached_file :photo
  
  has_many :teacher_certifications
  has_many :certifications, :through => :teacher_certifications
  belongs_to :provider
  
  attr_protected :provider
  
  validates_presence_of :first_name, :last_name
  validates_presence_of :provider
end
