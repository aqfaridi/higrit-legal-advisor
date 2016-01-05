class CreateVotetypes < ActiveRecord::Migration
  def change
    create_table :votetypes do |t|
      t.column :upvote,:integer,:default => 1
      t.column :downvote,:integer,:default => -1
      t.column :ac,:integer,:default => 0
      t.timestamps null: false
    end
  end
end
