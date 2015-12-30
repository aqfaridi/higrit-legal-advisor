class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.column :name, :string, :limit => 32, :null => false
      t.column :mobile, :string, :limit => 10, :null => false 
      t.column :email, :string,:null => false, :unique => true
      t.column :salt, :string
      t.column :password, :string,:null => false
      t.column :gender, :string,:null => false
      t.column :dob, :string
      t.column :imagename, :string,:default => "default.jpg"  
      t.column :about, :text
      t.column :ckey, :string
      t.column :ctime, :string
      t.column :mobileflag, :string, :default => "0"  
      t.column :emailflag, :string, :default => "0"  
      t.timestamps null: false
    end
  end
end
