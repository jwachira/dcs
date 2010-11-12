class CreateChildMedicalConditions < ActiveRecord::Migration
  def self.up
    create_table :child_medical_conditions do |t|
      t.references :child
      t.references :medical_conditions
      t.timestamps
    end
  end

  def self.down
    drop_table :child_medical_conditions
  end
end
