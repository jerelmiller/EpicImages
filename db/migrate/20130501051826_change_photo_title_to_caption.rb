class ChangePhotoTitleToCaption < ActiveRecord::Migration
  def up
    rename_column :photos, :title, :caption
  end

  def down
    rename_column :photos, :caption, :title
  end
end
