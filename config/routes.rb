Rails.application.routes.draw do
  devise_for :users

  resources :users, only: %i[show index] do
    get 'search', on: :collection
    resource :profile, only: %i[new create edit update]
    resources :friendships, only: %i[index new create destroy]
  end

  post 'users/:id', to: 'profiles#create'
  get 'users/:id/profile', to: 'users#show'
  post 'users/:id/friendships', to: 'friendships#create'

  get 'search', to: 'users#search'

  resources :notifications, only: %i[index]
  delete 'notifications', to: 'notifications#destroy_multiple'

  resources :posts
  resources :comments, only: %i[index create destroy]
  resources :likes, only: %i[index create destroy]

  devise_scope :user do
    root 'devise/sessions#new'
  end

end
