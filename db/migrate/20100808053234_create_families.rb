class CreateFamilies < ActiveRecord::Migration
  def self.up
    create_table :families do |t|
      t.references :provider
      t.boolean    :active
      t.date       :deleted_at
      t.timestamps
    end
  end

  def self.down
    drop_table :families
  end
end
