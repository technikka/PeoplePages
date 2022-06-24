Rails.application.routes.draw do
  devise_for :users
  resources :users, only: %i[show index] do
    get 'search', on: :collection
    resource :profile, only: %i[new create edit update]
    resources :friendships, only: %i[new create destroy]
  end

  get 'search', to: 'users#search'
  post 'users/:id', to: 'profiles#create'
  get 'users/:id/profile', to: 'users#show'
  get 'users/:id/friendships', to: 'friendships#create'

  root 'users#show'
end
