class Comment < ActiveRecord::Base
  belongs_to :users
  belongs_to :posts
  has_many :votecoms
end
