class CreateLinkedAccounts < ActiveRecord::Migration
  def change
    create_table :linked_accounts do |t|
      t.integer :user_id
      t.integer :external_account_id
      t.string :external_user_id
      t.string :external_meta_info
      t.timestamps null: false
    end
  end
end
