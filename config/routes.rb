Rails.application.routes.draw do
  root 'bids#index'

  devise_for :users,
             controllers: { registrations: 'users/registrations' }
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
    resource :bid, only: [:show, :create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  concern :manage_products do
    resources :products do
      resources :bids, only: [:index, :show]
      resources :pictures, only: [:create, :destroy]
    end
  end

  namespace :admin do
    resources :users do
      resources :products, only: [:index]
    end
    concerns :manage_products
  end

  namespace :seller do
    concerns :manage_products
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
end
