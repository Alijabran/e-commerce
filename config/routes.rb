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

      member do
        post :product_coupon
      end
    end
end
