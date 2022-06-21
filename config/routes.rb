Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  resources :users, only: [:show]

  devise_scope :user do
    root to: 'devise/sessions#new'
  end
end
