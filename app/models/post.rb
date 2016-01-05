class Post < ActiveRecord::Base
  belongs_to :users
  belongs_to :categories 
  has_many :voteposts
  has_many :comments
  has_many :postags
end
