class UsersController < ApplicationController
  def new
  end

  def create
    @user = User.new(params.require(:user).permit(:username, :password))
    if @user.save
      login(@user)
      # redirect_to posts_url 
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end
end
