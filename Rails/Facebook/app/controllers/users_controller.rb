class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
  	@user 			        	= current_user

#SQL to get id for both passive and active friends // !! including current user !!
    friends_ids = "SELECT friend_id FROM friendships 
                  WHERE ( user_id = :user_id AND friendship_accepted = true )
                     OR ( friend_id = :user_id AND friendship_accepted = true )"
    users_ids   = "SELECT user_id FROM friendships 
                  WHERE ( user_id = :user_id AND friendship_accepted = true )
                     OR ( friend_id = :user_id AND friendship_accepted = true )"

    #@friends = User.where("id IN (#{friends_ids}) OR id IN (#{users_ids})", user_id: @user.id)

    @feed = Post.where("author_id IN (#{friends_ids}) OR author_id IN (#{users_ids})
                  OR author_id = :user_id", user_id: @user.id)

    @post                 = @user.posts.build
    @like                 = Like.new

  	@friends_passive	    = @user.passive_friends.where(  "friendship_accepted = ?", true )
    @friends_active       = @user.active_friends.where(  "friendship_accepted = ?", true )
  	@invited_friends    	= @user.active_friends.where(  "friendship_accepted = ?", false )
    @pending_friends      = @user.passive_friends.where( "friendship_accepted = ?", false )

    #all his friends for the feed
    @feeds_users = User.select do |u|
      @friends_active.includes(u)  || @friends_passive.includes(u)
    end

    #User.includes(:friendship).where("friendship_accepted = ?", false)
  	#@potential_friends    = User.where('id NOT IN (SELECT DISTINCT(user_id) FROM friendships)')
    
  end

  def index
  	@user                = current_user
    @friends_passive      = @user.passive_friends.where(  "friendship_accepted = ?", true )
    @friends_active       = @user.active_friends.where(  "friendship_accepted = ?", true )
    @invited_friends      = @user.active_friends.where(  "friendship_accepted = ?", false )
    @pending_friends      = @user.passive_friends.where( "friendship_accepted = ?", false )

    @potential_friends    = User.select do |u| 
        u != @user && @friends_passive.exclude?(u)&& @friends_active.exclude?(u) && @invited_friends.exclude?(u) && @pending_friends.exclude?(u)
    end

  end
  
end



