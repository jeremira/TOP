class User < ApplicationRecord
  has_many :active_friendships,  class_name: "Friendship",
  								 foreign_key: "user_id",
  								 dependent: :destroy
  has_many :active_friends, through: :active_friendships, source: :friend 
                              

  has_many :passive_friendships, class_name: "Friendship",
  								 foreign_key: "friend_id",
  								 dependent: :destroy
  has_many :passive_friends, through: :passive_friendships, source: :user
         
  has_many :posts, foreign_key: "author_id", dependent: :destroy                     
      
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

end
