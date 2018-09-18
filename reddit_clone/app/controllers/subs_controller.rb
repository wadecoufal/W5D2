class SubsController < ApplicationController
  before_action :require_login, except: [:show, :index]
  
  def new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.new[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def show
    @sub = Sub.find_by(id: params[:id])
  end

  def edit
    @sub = Sub.find_by(id: params[:id], moderator_id: current_user.id)
    unless @sub
      flash[:errors] = ["You do not have permission to edit this Sub"]
      logout
      redirect_to new_session_url 
    end
    render :edit
  end

  def update
    @sub = Sub.find_by(id: params[:id], moderator_id: current_user.id)
    unless @sub
      flash[:errors] = ["You do not have permission to edit this Sub"]
      logout
      redirect_to new_session_url 
    end
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def index
    @subs = Sub.all
  end
  
  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
