class PostsController < ApplicationController
  before_action :require_login, except: [:show]
  
  def new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find_by(id: params[:id], author_id: current_user.id)
    unless @post
      flash[:errors] = ['You cannot edit this post']
      logout
      redirect_to new_session_url
    end
  end

  def update
    @post = Post.find_by(id: params[:id], author_id: current_user.id)
    unless @post
      flash[:errors] = ['You cannot edit this post']
      logout
      redirect_to new_session_url
    end
    
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    redirect_to subs_url
  end
  
  private
  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end
end
