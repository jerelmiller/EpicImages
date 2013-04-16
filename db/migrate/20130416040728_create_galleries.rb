class CreateGalleries < ActiveRecord::Migration
  def up
    create_table :galleries do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_attachment :galleries, :cover_photo
  end

  def down
    drop_table :galleries
  end
end
