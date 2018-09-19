class VotesController < ApplicationController
  before_action :require_login
  
  def create
    old_vote = Vote.find_by(
      user_id: current_user.id, 
      voteable_id: params[:vote][:voteable_id])
    old_vote.destroy if old_vote
    
    @vote = Vote.new(vote_params)
    @vote.user_id = current_user.id
    if @vote.save
    else
      flash[:errors] = @vote.errors.full_messages
    end
    redirect_to post_url(@vote.voteable_id) if @vote.voteable_type == "Post"
    redirect_to comment_url(@vote.voteable_id) if @vote.voteable_type == "Comment"
  end
  
  private
  def vote_params
    params.require(:vote).permit(:upvote, :voteable_type, :voteable_id)
  end
end
