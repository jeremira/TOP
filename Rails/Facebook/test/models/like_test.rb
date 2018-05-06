require 'test_helper'

class LikeTest < ActiveSupport::TestCase

  def setup
  	@user = users(:babar)
  	@post = posts(:one)
  	@like = @post.likes.build(user_id: @user.id)
  end

  test "should be valid" do 
  	assert @like.valid?
  end

  test "should have a user" do 
  	@like.user_id = nil 
  	assert_not @like.valid?
  end

  test "should have a post" do 
  	@like.post_id = " "
  	assert_not @like.valid?
  end

  test "should destroy like when corresponding post is destroyed" do 
  	@post.save
  	@like.save
  	assert_difference "Like.count", -1 do 
  		@post.destroy
  	end
  end

end
