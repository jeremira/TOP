Rails.application.routes.draw do
  get 'static/home'

  root 'static#home'

  resources :backgrounds
  resources :characters

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
