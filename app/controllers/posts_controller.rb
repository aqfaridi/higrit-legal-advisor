class PostsController < ApplicationController
	respond_to :json,:html,:js

	def new
	  @post = Post.new
	  @tag = Tag.order('rank DESC')
	  @ptag = Postag.where(post_id:@post.id)
	end

	def create 
		@userid = session[:userid]
		@title = params[:posted][:title]
		@tags = params[:posted][:tags]
		@cat_id = params[:posted][:category]
		@content = params[:posted][:content]
		
		t = @tags.split(/\W+/)

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
		@posts = Post.order('id DESC')
		@tag = Tag.order('rank DESC')
	end

	def show
	  @post = Post.find(params[:id])
	  
	  @f = View.find_by_post_id(@post.id)
	  if @f != nil
	  	c = @f.total_view_count + 1
	  	@f.update_attributes(total_view_count:c)
	  else
	  	@f = View.create(post_id:@post.id,total_view_count:1)
	  end

	  @user = User.find(@post.user_id)	 
	  @comment = Comment.new
	  @liked = Votepost.where("post_id = ? AND vote_type = ?",@post.id,1).count
	  @negliked = Votepost.where("post_id = ? AND vote_type = ?",@post.id,-1).count
	
	  @tag = Tag.order('rank DESC')
	  @ptag = Postag.where(post_id:@post.id)
	  @comments = Comment.where(post_id:@post.id).hash_tree
	end

	def destroy 
	end

	def like
	  @post = Post.find(params[:id])
	  @userid = session[:userid]
	  f = Votepost.where("post_id = ? AND user_id = ?",@post.id,@userid).first
	  if f != nil
	  	f.update_attributes(vote_type:1)
	  else
	  	Votepost.create(post_id:@post.id,user_id:@userid,vote_type:1)
	  end

	  @liked = Votepost.where("post_id = ? AND vote_type = ?",@post.id,1).count
	  @negliked = Votepost.where("post_id = ? AND vote_type = ?",@post.id,-1).count

	  if request.xml_http_request?
        render json: { pcount: @liked,ncount:@negliked, id: params[:id] }
      else
        logger.debug "Ajax request false"
      end
      
	  #redirect_to @post
	end

	def dislike
	  @post = Post.find(params[:id])
	  @userid = session[:userid]
	  f = Votepost.where("post_id = ? AND user_id = ?",@post.id,@userid).first
	  if f != nil
	  	f.update_attributes(vote_type:-1)
	  else
	  	Votepost.create(post_id:@post.id,user_id:@userid,vote_type:-1)
	  end
      
      @liked = Votepost.where("post_id = ? AND vote_type = ?",@post.id,1).count
	  @negliked = Votepost.where("post_id = ? AND vote_type = ?",@post.id,-1).count
  
      if request.xml_http_request?
        render json: { pcount: @liked,ncount:@negliked, id: params[:id] }
	  end

	  #redirect_to @post
	end

	def isliked?(postid)
		userid = session[:userid]
		f = Votepost.where(user_id:userid,post_id:postid).first
		if f != nil
			return f.vote_type == 1
		else
			return 2
		end
	end

	def islikedcom?(comid)
		userid = session[:userid]
		f = Votecom.where(user_id:userid,com_id:comid).first
		if f != nil
			return f.vote_type == 1
		else
			return 2
		end
	end

	def isset
	  if(session[:signed] == false)
	  	redirect_to '/signup'
	  end
	end

	helper_method:isset
	helper_method:isliked?
	helper_method:islikedcom?
end
