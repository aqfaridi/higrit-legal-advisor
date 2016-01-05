class Postag < ActiveRecord::Base
  belongs_to :posts
  belongs_to :tags
end
