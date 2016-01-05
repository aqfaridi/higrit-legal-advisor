class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|    	
      t.column :user_id,:integer
      t.column :post_id,:integer
      t.column :content,:text
      t.column :flag,:boolean
      t.column :published_at,:datetime
      t.timestamps null: false
    end
  end
end
