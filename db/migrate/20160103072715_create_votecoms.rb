class CreateVotecoms < ActiveRecord::Migration
  def change
    create_table :votecoms do |t|
      t.column :com_id,:integer 
      t.column :user_id,:integer
      t.column :vote_type,:integer
      t.timestamps null: false
    end
  end
end
