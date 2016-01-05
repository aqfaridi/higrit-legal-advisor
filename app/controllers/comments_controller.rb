class CommentsController < ApplicationController

	def new 
	end

	def create
		@content = params[:comment][:content]
		@userid = session[:userid]
		@postid = params[:post_id]
		Comment.create(user_id:@userid,post_id:@postid,content:@content,flag:true)
    	redirect_to post_path(@postid)
	end

	def destroy 
	end

end
