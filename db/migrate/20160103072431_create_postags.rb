class CreatePostags < ActiveRecord::Migration
  def change
    create_table :postags, id:false do |t|
      t.column :post_id,:integer 
      t.column :tag_id,:integer
      t.timestamps null: false
    end
  end
end
