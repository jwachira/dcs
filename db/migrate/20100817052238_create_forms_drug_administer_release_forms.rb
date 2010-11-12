class CreateFormsDrugAdministerReleaseForms < ActiveRecord::Migration
  def self.up
    create_table :drug_administer_release_forms do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :drug_administer_release_forms
  end
end
