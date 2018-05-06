class PostsController < ApplicationController

  def new
  end

  def create
    @post = current_user.posts.build(params_post)
    redirect_to current_user if @post.save
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params_post)
      redirect_to current_user
    end
  end

  def destroy
    @post = Post.find(params[:id])
    redirect_to current_user if @post.destroy
  end 

  private
    def params_post
      params.require(:post).permit(:content)
    end

end
