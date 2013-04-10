class CreateTags < ActiveRecord::Migration
  def up
    create_table :tags do |t|
      t.string :name, null: false, unique: true
      t.timestamps
    end

    create_table :photos_tags do |t|
      t.integer :tag_id
      t.integer :photo_id
    end
  end

  def down
    drop_table :tags
    drop_table :photos_tags
  end
end
