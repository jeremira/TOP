class UsersController < ApplicationController

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		redirect_to @user
  	else
  		render'new'
  	end
  end

  def show
  	@user   = User.find_by(id: params[:id])
    if @user
       @upcoming_events = upcoming_events(@user)
       @prev_events = prev_events(@user)
    else
      redirect_to root_path
    end
  end

  def index
    @users = User.all 
  end

  def destroy
    log_out
    redirect_to root_path
  end
  
  private
    def user_params
    	params.require(:user).permit(:name, :email)
    end
end
