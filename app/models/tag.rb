class Tag < ActiveRecord::Base
  has_many :postags
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]	
end
