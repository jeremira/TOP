Rails.application.routes.draw do

  get 'home/index'
  
  devise_for :users

  resources :users, 		only: [:show, :index]
  resources :friendships, 	only: [:create, :destroy, :update]
  resources :posts
  resources :likes
  resources :comments

  root "home#index"

end
