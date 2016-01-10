class TagsController < ApplicationController

	def show
		@tag_id = params[:id]
		@posts = Postag.where(tag_id:@tag_id)
		@tag = Tag.order('rank DESC')
	end

end
