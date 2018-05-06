require 'test_helper'

class UserFriendshipsTest < ActionDispatch::IntegrationTest

  def setup 
  	@user = users(:babar)
  	@other_user = users(:kakoo)
  end
  
  test "should be a friend AFTER setting a friendship" do 
  	@user.save
  	@other_user.save
  	#not friend
  	assert_not @user.active_friends.include?(@other_user)
  	assert_not @other_user.passive_friends.include?(@user)
  	#friend
  	friendship = @user.active_friendships.create!(friend_id: 2)
  	assert @user.active_friends.include?(@other_user)
  	assert @other_user.passive_friends.include?(@user)
  end

  test "should not be friend anymore after destroying friendship" do 
  	@user.save
  	@other_user.save
  	friendship = @user.active_friendships.create!(friend_id: 2)
  	assert @user.active_friends.include?(@other_user)
  	assert @other_user.passive_friends.include?(@user)
  	friendship.destroy
  	assert_not @user.active_friends.include?(@other_user)
  	assert_not @other_user.passive_friends.include?(@user) 
  end


end
