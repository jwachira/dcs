class TeacherCertification < ActiveRecord::Base
  belongs_to :teacher
  belongs_to :certification
end
