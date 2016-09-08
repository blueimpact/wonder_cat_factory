Rails.application.routes.draw do
  root 'products#index'

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
    resource :bid, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  namespace :admin do
    resources :users do
      resources :products, only: [:index]
    end
    resources :products do
      resources :bids, only: [:index]
      resources :pictures, only: [:create, :destroy]
    end
  end

  namespace :seller do
    resources :products do
      resources :bids, only: [:index]
      resources :pictures, only: [:create, :destroy]
    end
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
end
