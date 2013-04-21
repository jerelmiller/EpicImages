class ChangeGalleriesToTags < ActiveRecord::Migration
  def up
    drop_table :galleries
    add_column :tags, :gallery_flag, :boolean, null: false, default: false
    add_column :tags, :photo_id, :integer, default: nil
  end

  def down
    remove_column :tags, :gallery_flag
    remove_column :tags, :photo_id
    create_table :galleries do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_attachment :galleries, :cover_photo
  end
end
