class CreatePropertySites < ActiveRecord::Migration
  def self.up
    create_table :property_sites do |t|
      t.references :property_group
      t.string :name
      t.string :description
      t.string :street_address
      t.string :city
      t.string :postal_code
      t.string :state
      t.string :country
      t.boolean :active
      t.timestamps
    end
    add_index :property_groups, :name
  end

  def self.down
    drop_table :property_sites
  end
end
