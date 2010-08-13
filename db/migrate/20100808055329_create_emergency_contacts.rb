class CreateEmergencyContacts < ActiveRecord::Migration
  def self.up
    create_table :emergency_contacts do |t|
      t.references :family
      t.string :first_name
      t.string :last_name
      t.string :relationship_to_child 
      t.string :primary_phone
      t.string :secondary_phone
      t.string :email
      t.string :street_address
      t.string :city
      t.string :postal_code
      t.timestamps
    end
  end

  def self.down
    drop_table :emergency_contacts
  end
end
