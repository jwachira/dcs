class CreatePropertyGroups < ActiveRecord::Migration
  def self.up
    create_table :property_groups do |t|
      t.string :name
      t.string :description
      t.string :street_address
      t.string :city
      t.string :postal_code
      t.string :state
      t.string :country
      t.timestamps
    end
    add_index :property_groups, :name
  end

  def self.down
    drop_table :property_groups
  end
end
