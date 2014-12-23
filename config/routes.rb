Rails.application.routes.draw do
  resources :users
  resources :clubs
  resources :events
  resources :participations
  resources :sessions, only: [:new, :create]

  post 'users/validity', to: 'users#check'
  post 'users/user_club', to: 'users#user_club'
  post 'users/delete_by_name', to: 'users#delete_by_name'

  post 'clubs/validity', to: 'clubs#check'
  post 'clubs/add_members', to: 'clubs#addMembers'
  post 'clubs/get_members_by_club', to: 'clubs#getMembers'

  post 'friends/registeredFriends', to: 'friends#registeredFriends'
end
