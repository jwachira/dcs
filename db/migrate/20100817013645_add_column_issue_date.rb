class AddColumnIssueDate < ActiveRecord::Migration
  def self.up
    add_column :child_immunizations, :last_dose_date, :date
    add_column :child_immunizations, :next_dose_date, :date
    add_column :child_immunizations, :administered,   :boolean
    add_column :child_immunizations, :exempted,       :boolean
  end

  def self.down
    remove_column :child_immunizations, :exempted
    remove_column :child_immunizations, :administered
    remove_column :child_immunizations, :next_dose_date
    remove_column :child_immunizations, :last_dose_date
  end
end
