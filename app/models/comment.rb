class Comment < ActiveRecord::Base
  belongs_to :users
  belongs_to :posts
  has_many :votecoms

  acts_as_tree order: 'created_at DESC'
end
