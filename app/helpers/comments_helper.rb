module CommentsHelper
  def comments_tree_for(comments)
    comments.map do |comment, nested_comments|
      render(comment) +
          (nested_comments.size > 0 ? content_tag(:div, comments_tree_for(nested_comments), class: "replies",style:"margin-left:50px;") : nil)
    end.join.html_safe
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
  
end
