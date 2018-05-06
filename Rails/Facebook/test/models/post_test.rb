require 'test_helper'

class PostTest < ActiveSupport::TestCase
   def setup 
   	@user = users(:babar)
   	@post =  @user.posts.build(content: "Bla Bla Bla Bla")
   end

   test "Post should be valid" do 
    assert @user.valid?
   	assert @post.valid?
   end

   test "Author should be present" do 
     @post.author_id = nil 
     assert_not @post.valid?
   end

   test "Content should be present" do 
     @post.content = ""
     assert_not @post.valid?
   end

   test "should be ordered first" do 
   	assert_equal posts(:most_recent), Post.first
   end 

   test "destroying a user should destroy related post" do 
   	@user.save 
   	@post.save
   	#3 post in fixture + @post = -4 post after destroyed
   	assert_difference 'Post.count', -4 do 
  		@user.destroy 
  	end
   end
   
end
