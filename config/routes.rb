Rails.application.routes.draw do
  root 'bids#index'

  devise_for :users,
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations',
               confirmations: 'users/confirmations'
             }
  devise_scope :user do
    get 'login' => 'devise/sessions#new', as: :login
    delete 'logout' => 'devise/sessions#destroy', as: :logout
  end

  resource :users do
    collection do
      get :available
    end
  end
  resources :products, only: [:show] do
    resource :bid, only: [:show, :create, :destroy] do
      resources :events, only: [:index]
      collection do
        post :charge
      end
    end
    resources :comments, only: [:create, :destroy]
  end

  concern :manage do
    resources :products do
      resources :events, only: [:index]
      resources :bids, only: [:index, :show] do
        resources :events, only: [:index]
      end
      resources :instructions, only: [:index, :new, :edit, :create, :update, :destroy]
      resources :pictures, only: [:create, :destroy]
      member do
        post :start
        post :accept
      end
    end
  end

  namespace :admin do
    concerns :manage
    resources :users do
      resources :products, only: [:index]
      resource :stripe_accounts
    end

  end

  namespace :seller do
    concerns :manage
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
end
