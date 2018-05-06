class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
  	@user = User.find_by(name: params[:session][:name])
  	if @user
      log_in @user
  		redirect_to @user
  	else
  		render 'new'
  	end
  end
  
end
