Rails.application.routes.draw do
  resources :users
  resources :clubs
  resources :events
  resources :participations
  resources :drinks
  resources :fines
  resources :drink_payments
  resources :fine_payments
  resources :sessions, only: [:new, :create]

  #Users
  post 'users/validity', to: 'users#check'
  post 'users/user_club', to: 'users#user_club'

  #Clubs
  post 'clubs/validity', to: 'clubs#check'
  post 'clubs/add_members', to: 'clubs#add_members'
  post 'clubs/get_members_by_club', to: 'clubs#get_members'

  #Events
  post 'events/get_events_by_club', to: 'events#get_events_by_club'
  post 'events/get_participants', to: 'events#get_participants'

  #Friends
  post 'friends/getRegisteredFriends', to: 'friends#getRegisteredFriends'
  post 'friends/removeFriendFromClub', to: 'friends#removeFriendFromClub'

  #Drinks
  post 'drinks/get_by_club', to: 'drinks#get_by_club'

  #Fines
  post 'fines/get_by_club', to: 'fines#get_by_club'
end
