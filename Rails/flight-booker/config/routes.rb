Rails.application.routes.draw do
  
  root   'flights#index'
  get    '/flights',    to: 'flights#index'

  resources :flights
  resources :bookings

end
