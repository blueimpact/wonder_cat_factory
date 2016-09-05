Rails.application.routes.draw do
  root 'products#bidden'

  devise_for :users
  devise_scope :user do
    get 'login' => 'devise/sessions#new', as: :login
    delete 'logout' => 'devise/sessions#destroy', as: :logout
  end

  resources :products do
    resource :bid, only: [:create, :destroy]
    resources :bids, only: [:index]
    resources :pictures, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
    collection do
      get :bidden
    end
  end

  namespace :admin do
    resources :users do
      resources :products, only: [:index]
    end
    resources :products, only: [:index, :show]
  end

  namespace :seller do
    resources :products, only: [:index, :show]
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
end
