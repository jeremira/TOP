class SessionsController < ApplicationController

	def new
		@current_user = current_user
		redirect_to @current_user if @current_user
	end

	def create
		user = User.find_by(name: params[:sessions][:name])
		if user && user.authenticate(params[:sessions][:password])
			log_in user
			redirect_to user
		else
			render 'new'
		end
	end

	def destroy
		log_out
		redirect_to root_path
	end
	
end
