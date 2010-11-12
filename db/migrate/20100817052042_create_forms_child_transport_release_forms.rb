class CreateFormsChildTransportReleaseForms < ActiveRecord::Migration
  def self.up
    create_table :child_transport_release_forms do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :child_transport_release_forms
  end
end
