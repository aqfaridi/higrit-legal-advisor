class CreateViews < ActiveRecord::Migration
  def change
    create_table :views do |t|
      t.column :post_id,:integer 
      t.column :total_view_count,:integer,:default=>0
      t.timestamps null: false
    end
  end
end
