class CreateImmunizations < ActiveRecord::Migration
  def self.up
    create_table :immunizations do |t|
      t.string  :name
      t.text    :description
      t.boolean :active
      t.integer :position
      t.timestamps
    end
    add_index :immunizations, :name
  end

  def self.down
    drop_table :immunizations
  end
end
