class AddExternalCreatedTimeToClipping < ActiveRecord::Migration
  def change
    add_column :clippings, :external_created_time, :integer
  end
end
