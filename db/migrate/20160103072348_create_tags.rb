class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.column :name,:string
      t.column :rank,:integer
      t.timestamps null: false
    end
  end
end
