Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]
  resources :profiles, only: %i[new create edit update]

  root 'users#show'
end
