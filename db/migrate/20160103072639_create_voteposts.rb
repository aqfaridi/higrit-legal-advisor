class CreateVoteposts < ActiveRecord::Migration
  def change
    create_table :voteposts,id:false do |t|
      t.column :post_id,:integer 
      t.column :user_id,:integer
      t.column :vote_type,:integer
      t.timestamps null: false
    end
  end
end
