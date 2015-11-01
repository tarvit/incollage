class AddSourceIdToClipping < ActiveRecord::Migration
  def change
    add_column :clippings, :source_id, :integer
  end
end
