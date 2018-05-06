require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup 
  	@user = users(:babar)
  	@other_user = users(:kakoo)
  end

  test "should be valid" do 
  	assert @user.valid?
  end

  test "email should be present" do
  	@user.email = ""
  	assert_not @user.valid?
  end

  test "email adresse should be unique" do 
  	@duplicate_user = @user.dup 
  	@duplicate_user.save 
  	assert_not @duplicate_user.valid?
  end

  test "associated friendships should be destroyed" do 
  	@user.save 
  	@other_user.save
  	@user.active_friendships.create!(friend_id: 2)
  	assert_difference 'Friendship.count', -1 do 
  		@user.destroy 
  	end
  end

end
