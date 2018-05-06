Rails.application.routes.draw do
	resources :sessions, :users, :posts
	root 'sessions#new'

	get  '/login',		to: 'sessions#new'
    post '/login',		to: 'sessions#create'
    get  '/logout', 	to: 'sessions#destroy'

    get  '/signin', 	to: 'users#new'


end
