class CreateTeachers < ActiveRecord::Migration
  def self.up
    create_table :teachers do |t|
      t.references :provider
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :gender
      t.string :phone_number
      t.string :email
      t.string :street_address
      t.string :city
      t.string :postal_code
      t.string :state
      t.string :degree
      t.string :date_of_birth
      t.string :field_of_study
      t.string :title
      t.text   :description
      t.string :years
      t.boolean :active
      t.timestamps
    end
  end

  def self.down
    drop_table :teachers
  end
end
