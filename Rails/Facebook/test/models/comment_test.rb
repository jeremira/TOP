require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  def setup
   	@post    = posts(:one)
   	@comment = @post.comments.build(user_id: @post.author_id, content: "LOL")
  end

   test "Comment should be valid" do 
   	assert @post.valid?
   	assert @comment.valid?
   end

   test "User should be present" do 
     @comment.user_id = nil 
     assert_not @comment.valid?
   end

   test "Content should be present" do 
     @comment.content = ""
     assert_not @comment.valid?
   end

   test "Post should be present" do 
     @comment.post_id = ""
     assert_not @comment.valid?
   end

   test "should be ordered first" do 
   	assert_equal comments(:most_recent), Comment.first
   end 

   test "destroying a post should destroy related comment" do 
   	@post.save
   	@comment.save
   	#2 comment in fixture + @comment = -3 comment after destroyed
   	assert_difference 'Comment.count', -4 do 
  		@post.destroy 
  	end
   end
end
