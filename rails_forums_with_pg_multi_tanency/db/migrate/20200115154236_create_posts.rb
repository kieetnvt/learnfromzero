class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.belongs_to :topic, foreign_key: true
      t.text :content
      t.boolean :inline_images

      t.timestamps
    end
  end
end
