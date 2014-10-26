Rails.application.routes.draw do
  resources :users
  resources :clubs
  resources :events
  resources :participations
  resources :sessions, only: [:new, :create]
end
