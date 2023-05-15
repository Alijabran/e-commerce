Rails.application.routes.draw do
  # devise_for :users
  root :to => redirect("/users/sign_in")

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # post '/users/sign_up', to: 'users#new'

  # resources :users
  # resources :users
  # get "users/sign_up" to: "devise#new";
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
