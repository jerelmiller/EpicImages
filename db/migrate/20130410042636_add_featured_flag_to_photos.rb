class AddFeaturedFlagToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :featured_flag, :boolean, null: false, default: false
  end
end
