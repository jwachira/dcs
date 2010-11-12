class CreateFormsEmergencyReleaseForms < ActiveRecord::Migration
  def self.up
    create_table :emergency_release_forms do |t|
      
      t.timestamps
    end
  end

  def self.down
    drop_table :emergency_release_forms
  end
end
