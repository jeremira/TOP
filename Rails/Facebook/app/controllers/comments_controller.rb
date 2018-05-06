class CommentsController < ApplicationController

	def create
      @comment = Comment.new(comment_params)
      redirect_to current_user if @comment.save
    end

    def edit
      @comment = Comment.find(params[:id])
    end

    def update
      @comment = Comment.find(params[:id])
      redirect_to current_user if @comment.update_attributes(comment_params)
    end

    def destroy
      @comment = Comment.find(params[:id])
      redirect_to current_user if @comment.destroy
    end

    private 
      def comment_params
        params.require(:comment).permit(:content, :post_id, :user_id)
      end

end
