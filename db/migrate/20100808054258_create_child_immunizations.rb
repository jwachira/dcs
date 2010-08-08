class CreateChildImmunizations < ActiveRecord::Migration
  def self.up
    create_table :child_immunizations do |t|
      t.references :child
      t.references :immunization
      t.boolean    :active
      t.timestamps
    end
  end

  def self.down
    drop_table :child_immunizations
  end
end
