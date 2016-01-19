class CommentsController < ApplicationController
	respond_to :json,:html,:js

	def new
		@comment = Comment.new(parent_id: params[:parent_id])
		@post = Post.find(params[:post_id])
	end

	def create
		@content = params[:comment][:content]
		@userid = session[:userid]
		@postid = Post.find(params[:post_id]).id #string of slug

		c = {user_id:@userid,post_id:@postid,content:@content,flag:true}
		if params[:comment][:parent_id].to_i > 0
    	  parent = Comment.find_by_id(params[:comment][:parent_id])
    	  @comment = parent.children.build(c)
  		else
   		  @comment = Comment.new(c)
	    end
		
		if @comment.save
    	  flash[:success] = 'Your comment was successfully added!'
    	  redirect_to post_path(params[:post_id])
  		else
    	  render 'new'
  		end

	end

	def destroy
	end

	def clike
	  postid =  Post.find(params[:post_id]).id	
	  @comid = params[:id]
	  @userid = session[:userid]
	  f = Votecom.where(com_id:@comid,user_id:@userid).first
	  if f != nil
	  	f.update_attributes(vote_type:1)
	  else
	  	Votecom.create(com_id:@comid,user_id:@userid,vote_type:1)
	  end

	  @cliked = Votecom.where("com_id = ? AND vote_type = ?",@comid,1).count
	  @negcliked = Votecom.where("com_id = ? AND vote_type = ?",@comid,-1).count

	  if request.xml_http_request?
        render json: { pcount: @cliked,ncount:@negcliked, id: params[:id] }
      else
        logger.debug "Ajax request false"
      end
      

	  #redirect_to post_path(postid)
	end

	def cdislike
	  postid =  Post.find(params[:post_id]).id	
	  @comid = params[:id]
	  @userid = session[:userid]
	  f = Votecom.where(com_id:@comid,user_id:@userid).first
	  if f != nil
	  	f.update_attributes(vote_type:-1)
	  else
	  	Votecom.create(com_id:@comid,user_id:@userid,vote_type:-1)
	  end
	  
	  @cliked = Votecom.where("com_id = ? AND vote_type = ?",@comid,1).count
	  @negcliked = Votecom.where("com_id = ? AND vote_type = ?",@comid,-1).count

	  if request.xml_http_request?
        render json: { pcount: @cliked,ncount:@negcliked, id: params[:id] }
      else
        logger.debug "Ajax request false"
      end

	  #redirect_to post_path(postid)
	end

end
