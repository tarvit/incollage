class AddExternalIdToClipping < ActiveRecord::Migration
  def change
    add_column :clippings, :external_id, :string
  end
end
