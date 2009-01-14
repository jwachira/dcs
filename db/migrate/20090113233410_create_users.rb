class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string   :first_name
      t.string   :last_name
      t.string   :crypted_password
      t.string   :password_salt
      t.string   :persistence_token
      t.string   :perishable_token
      t.integer  :login_count,      :null => false, :default => 0
      t.string   :email,            :null => false, :default => ""
      t.datetime :last_request_at
      t.datetime :last_login_at
      t.string   :current_login_at
      t.string   :last_login_ip
      t.string   :current_login_ip
    end
    add_index :users, :perishable_token
    add_index :users, :email
  end

  def self.down
    drop_table :users
  end
end
