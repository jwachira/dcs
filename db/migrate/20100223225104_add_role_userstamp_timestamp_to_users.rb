class AddRoleUserstampTimestampToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :role, :string, :limit => 20
    add_column :users, :creator_id, :integer
    add_column :users, :updater_id, :integer
    add_column :users, :created_at, :datetime
    add_column :users, :updated_at, :datetime
  end

  def self.down
    remove_column :users, :updated_at
    remove_column :users, :created_at
    remove_column :users, :updater_id
    remove_column :users, :creator_id
    remove_column :users, :role
  end
end
