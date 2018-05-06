class LikesController < ApplicationController

	def create
		@like = Like.new(:post_id => params[:post_id], :user_id => current_user.id)
		redirect_to current_user if @like.save
	end

	def destroy
		@like = Like.find_by(:post_id => params[:post_id], :user_id => current_user.id)
		redirect_to current_user if @like.destroy
	end

	private
  	  def like_params
  	  	params.require(:like).permit(:post_id, :user_id)
  	  end
end
