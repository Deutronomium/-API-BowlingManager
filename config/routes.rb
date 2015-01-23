Rails.application.routes.draw do
  resources :users
  resources :clubs
  resources :events
  resources :participations
  resources :sessions, only: [:new, :create]

  post 'users/validity', to: 'users#check'
  post 'users/user_club', to: 'users#user_club'

  post 'clubs/validity', to: 'clubs#check'
  post 'clubs/add_members', to: 'clubs#addMembers'
  post 'clubs/get_members_by_club', to: 'clubs#getMembers'

  post 'events/get_events_by_club', to: 'events#get_events_by_club'

  post 'friends/getRegisteredFriends', to: 'friends#getRegisteredFriends'
  post 'friends/removeFriendFromClub', to: 'friends#removeFriendFromClub'
end
