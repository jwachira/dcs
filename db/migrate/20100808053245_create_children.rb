class CreateChildren < ActiveRecord::Migration
  def self.up
    create_table :children do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :gender
      t.string :date_of_birth
      t.references :family
      t.string  :ssn
      t.boolean :requires_special_care
      t.boolean :foster_child
      t.boolean :immunized
      t.string  :enrollment_status
      t.boolean :active  
      t.timestamps
    end
  end

  def self.down
    drop_table :children
  end
end


