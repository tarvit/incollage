class CreateClippings < ActiveRecord::Migration
  def change
    create_table :clippings do |t|
      t.integer :user_id
      t.integer :collection_id
      t.string :picture_url
      t.string :histogram
      t.timestamps null: false
    end
  end
end
