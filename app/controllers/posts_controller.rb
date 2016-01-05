class PostsController < ApplicationController
	def new
	  @post = Post.new
	end

	def create 
		@userid = session[:userid]
		@title = params[:posted][:title]
		@tags = params[:posted][:tags]
		@cat_id = params[:posted][:category]
		@content = params[:posted][:content]
		
		t = @tags.split(' ,')

		@post = Post.create(title:@title,content:@content,user_id:@userid,flag:false,cat_id:@cat_id)
		if(@post.id != nil)
			t.each do |tag|
				var = Tag.find_by_name(tag)
				if(var == nil)
					var = Tag.create(name:tag,rank:1)
				else
					var.update_attributes(rank:var.rank + 1)
				end 

				Postag.create(post_id:@post.id,tag_id:var.id)
			end

			redirect_to '/home'
		end

	end


	def index
		@posts = Post.all
	end

	def show
	  @post = Post.find(params[:id])
	  @user = User.find(@post.user_id)	 
	  @comment = Comment.new
	  @ct = Comment.where(post_id:@post.id)
	end

	def destroy 
	end

	def isset
	  if(session[:signed] == false)
	  	redirect_to '/signup'
	  end
	end
	helper_method:isset
end
