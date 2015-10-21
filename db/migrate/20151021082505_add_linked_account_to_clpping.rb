class AddLinkedAccountToClpping < ActiveRecord::Migration
  def change
    add_column :clippings, :linked_account_id, :integer
  end
end
