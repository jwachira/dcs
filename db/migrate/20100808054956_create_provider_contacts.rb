class CreateProviderContacts < ActiveRecord::Migration
  def self.up
    create_table :provider_contacts do |t|
      t.references :provider
      t.string :first_name
      t.string :last_name
      t.string :title
      t.string :street_address
      t.string :city
      t.string :postal_code
      t.string :state
      t.string :email
      t.string :phone_number
      t.string :role
      t.timestamps
    end
  end

  def self.down
    drop_table :provider_contacts
  end
end
