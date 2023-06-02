Rails.application.routes.draw do
  root to: 'products#index'
  
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
  }

  resources :invitations, only: %i[new create]

  resources :products do 
    collection do
      get :export
    end
    resources :orders 
  end

  resources :users do 
    member do 
      patch :update
    end 

    collection do
      get :export
    end
  end
  
  resources :categories 
  
  resources :coupons do
    collection do
      get :export
    end
  end

  resources :orders 

  resources :checkout do 
    collection do
      post :create_session
    end
      post :expire_session
      get :sessions
      get :line_items
    collection do
      get :success
    end
  end


end
