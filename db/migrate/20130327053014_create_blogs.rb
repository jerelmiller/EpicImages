class CreateBlogs < ActiveRecord::Migration
  def up
    create_table :blogs do |t|
      t.string :title, default: nil
      t.text :body, default: nil

      t.timestamps
    end
  end

  def down
    drop_table :blogs
  end
end
