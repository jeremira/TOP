require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
 
  def setup
     @friendship = Friendship.new( user_id: users(:babar).id, friend_id: users(:kakoo).id )
   end

   test "should be valid" do 
    assert @friendship.valid?
   end

   test "should require a user_id" do 
   	@friendship.user_id = nil
   	assert_not @friendship.valid?
   end

   test "should require a friend_id" do 
   	@friendship.friend_id = nil
   	assert_not @friendship.valid?
   end

   test "should not be activated on creation" do
   	assert @friendship.friendship_accepted == false
   end

end
