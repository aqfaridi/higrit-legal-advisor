class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|	
      t.column :title,:string
      t.column :content,:text
      t.column :url,:string
      t.column :user_id,:integer
      t.column :closed_at,:datetime
      t.column :flag,:boolean
      t.column :cat_id,:integer
      t.column :published_at,:datetime	
      t.timestamps null: false
    end
    add_index :posts, :id, unique: true
    add_index :posts, :published_at
  end
end
