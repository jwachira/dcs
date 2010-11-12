class CreateMedicalConditions < ActiveRecord::Migration
  def self.up
    create_table :medical_conditions do |t|
      t.string  :name
      t.text    :description
      t.boolean :active
      t.timestamps
    end
  end

  def self.down
    drop_table :medical_conditions
  end
end
