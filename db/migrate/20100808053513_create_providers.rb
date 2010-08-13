class CreateProviders < ActiveRecord::Migration
  def self.up
    create_table :providers do |t|
      t.references :user
      t.string :name
      t.string :street_address
      t.string :city
      t.string :postal_code
      t.string :state
      t.string :phone_number
      t.string :secondary_phone_number
      t.string :fax
      t.string :license_number
      t.string :license_effective_date
      t.string :license_expiry_date      
      t.timestamps
    end
  end

  def self.down
    drop_table :providers
  end
end

