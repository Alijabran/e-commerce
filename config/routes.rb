Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :users
  root to: 'users#index'
  patch '/users/:id', to: 'users#update', as: 'update_user'
  
end
