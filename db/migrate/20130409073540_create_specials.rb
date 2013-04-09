class CreateSpecials < ActiveRecord::Migration
  def up
    create_table :specials do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.timestamps
    end

    add_attachment :specials, :poster
  end

  def down
    drop_table :specials
  end
end
