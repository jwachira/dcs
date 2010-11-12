class CreateFormsMediaReleaseForms < ActiveRecord::Migration
  def self.up
    create_table :media_release_forms do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :media_release_forms
  end
end
