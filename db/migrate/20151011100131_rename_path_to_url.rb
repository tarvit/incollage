class RenamePathToUrl < ActiveRecord::Migration
  def change
    rename_column :clippings, :file_path, :picture_url
  end
end
