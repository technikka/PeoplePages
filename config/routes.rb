Rails.application.routes.draw do
  devise_for :users
  resources :users, only: %i[show index] do
    get 'search', on: :collection
    resource :profile, only: %i[new create edit update]
  end

  get 'search', to: 'users#search'
  post 'users/:id', to: 'profiles#create'
  get 'users/:id/profile', to: 'users#show'

  root 'users#show'
end
