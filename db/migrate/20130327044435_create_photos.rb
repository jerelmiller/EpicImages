class CreatePhotos < ActiveRecord::Migration
  def up
    create_table :photos do |t|
      t.string :title, default: nil
      t.timestamps
    end

    add_attachment :photos, :image
  end

  def down
    drop_table :photos
  end
end
