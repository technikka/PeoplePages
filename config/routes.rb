Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show] do
    resource :profile, only: %i[new create edit update]
  end

  post 'users/:id', to: 'profiles#create'
  # post '/', to: 'profiles#create'

  root 'users#show'
end
