class CommentsController < ApplicationController
  def show
    @comment = Comment.find_by(id: params[:id])
  end

  def new
    @comment = Comment.new
    @comment.post_id = params[:post_id] if params[:post_id]
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.post_id = params[:post_id] if params[:post_id]
    @comment.author_id = current_user.id
    
    if @comment.save
      redirect_to post_url(@comment.post)
    else
      flash[:errors] = @comment.errors.full_messages
      
      if @comment.parent_comment_id
        redirect_to comment_url(@comment.parent_comment_id)
      else  
        redirect_to post_url(@comment.post_id)
      end
      
    end
    
  end
  
  def comment_params
    params.require(:comment).permit(:content, :parent_comment_id, :post_id) 
  end
end
