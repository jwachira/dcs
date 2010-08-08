class CreateFamilies < ActiveRecord::Migration
  def self.up
    create_table :families do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :street_address
      t.string :city
      t.string :postal_code
      t.string :state
      t.string :primary_phone_number
      t.string :secondary_phone_number
      t.string :date_of_birth
      t.string :relationship_to_child
      t.string :ssn
      t.boolean :active
      t.timestamps
    end
  end

  def self.down
    drop_table :families
  end
end
