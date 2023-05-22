Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    invitations: 'users/invitations'
  }

  resources :invitations, only: %i[new create]
  resources :products

  root to: 'users#index'

    resources :users do 
      member do 
        patch :update
      end 

      collection do
        get :export
      end
    end

end
