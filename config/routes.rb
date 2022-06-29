Rails.application.routes.draw do
  devise_for :users
  resources :users, only: %i[show index] do
    get 'search', on: :collection
    resource :profile, only: %i[new create edit update]
    resources :friendships, only: %i[index new create destroy]
  end
  resources :notifications, only: %i[index]

  get 'search', to: 'users#search'
  post 'users/:id', to: 'profiles#create'
  get 'users/:id/profile', to: 'users#show'
  post 'users/:id/friendships', to: 'friendships#create'

  root 'users#show'
end
