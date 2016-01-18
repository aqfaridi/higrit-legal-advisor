class Post < ActiveRecord::Base
  belongs_to :users
  belongs_to :categories 
  has_many :voteposts
  has_many :comments
  has_many :postags
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]
end
