Rails.application.routes.draw do
  #  devise_for :users
  # root "users#index"

  # devise_scope :user do
  #   root to: "devise/sessions#new"
  # end

  # devise_scope :user do
  #   # root "users#index"
  #   resources :users
  # end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :users

  root to: 'users#index'

  # devise_for :users, views: {
  #   sessions: 'users/sessions',
  #   registrations: 'users/registrations'
  # }

  # post '/users/sign_up', to: 'users#new'

  # resources :users
  # resources :users
  # get "users/sign_up" to: "devise#new";
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
