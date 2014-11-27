Rails.application.routes.draw do
  resources :users
  resources :clubs
  resources :events
  resources :participations
  resources :sessions, only: [:new, :create]

  post 'users/validity', to: 'users#check'

  post 'clubs/validity', to: 'clubs#check'

  post 'friends/registeredFriends', to: 'friends#registeredFriends'
end
