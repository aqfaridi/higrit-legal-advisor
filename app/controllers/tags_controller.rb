class TagsController < ApplicationController

	def show
		@tag_id = Tag.find(params[:id]).id
		@posts = Postag.where(tag_id:@tag_id)
		@tag = Tag.order('rank DESC')		
		@recents = Post.order('id DESC').limit(2)
	end

end
