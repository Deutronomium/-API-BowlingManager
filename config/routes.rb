Rails.application.routes.draw do
  resources :users
  resources :clubs
  resources :events
  resources :participations
end
