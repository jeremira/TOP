class PostsController < ApplicationController

	def new
		@post = Post.new
	end

	def create
		@post = current_user.posts.build(post_params)
		@post.save
		redirect_to root_url
	end

	def index
		@post = Post.all
	end

private

	def post_params
		params.require(:post).permit(:content)
	end

end
