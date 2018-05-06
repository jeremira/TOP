class FriendshipsController < ApplicationController
	before_action :authenticate_user!

	def new
		@friendship = Friendship.new
	end

	def update
		@friendship = Friendship.find(params[:id])
		@friendship.update_attribute(:friendship_accepted, true)
		redirect_to current_user
	end

	def create
		@friend = User.find(params[:friend_id])
		current_user.active_friendships.create( friend_id: @friend.id )
		redirect_to current_user
	end

	def destroy
		@friendship = Friendship.find(params[:id])
		@friendship.destroy
		redirect_to current_user
	end

end
