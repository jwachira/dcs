class CreateFormsParentFeeContractForms < ActiveRecord::Migration
  def self.up
    create_table :parent_fee_contract_forms do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :parent_fee_contract_forms
  end
end
