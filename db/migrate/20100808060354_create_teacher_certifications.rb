class CreateTeacherCertifications < ActiveRecord::Migration
  def self.up
    create_table :teacher_certifications do |t|
      t.references :teacher
      t.references :certification
      t.date       :issue_date
      t.date       :expiration_date
      t.timestamps
    end
  end

  def self.down
    drop_table :teacher_certifications
  end
end
