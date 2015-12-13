class AddColorIndex < ActiveRecord::Migration
  def change
    add_column :clippings, :color_1, :integer, default: 0
    add_column :clippings, :color_2, :integer, default: 0
    add_column :clippings, :color_3, :integer, default: 0
    add_column :clippings, :color_4, :integer, default: 0
    add_column :clippings, :color_5, :integer, default: 0
    add_column :clippings, :color_6, :integer, default: 0
    add_column :clippings, :color_7, :integer, default: 0
    add_column :clippings, :color_8, :integer, default: 0
    add_column :clippings, :color_9, :integer, default: 0
    add_column :clippings, :color_10, :integer, default: 0
    add_column :clippings, :color_11, :integer, default: 0
    add_column :clippings, :color_12, :integer, default: 0
  end
end
