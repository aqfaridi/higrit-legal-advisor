class Votepost < ActiveRecord::Base
  belongs_to :posts
  belongs_to :users
end
