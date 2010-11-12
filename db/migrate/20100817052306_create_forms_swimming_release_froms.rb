class CreateFormsSwimmingReleaseFroms < ActiveRecord::Migration
  def self.up
    create_table :swimming_release_froms do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :swimming_release_froms
  end
end
