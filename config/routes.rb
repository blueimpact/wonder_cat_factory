Rails.application.routes.draw do
  root 'products#index'

  devise_for :users
  devise_scope :user do
    get 'login' => 'devise/sessions#new', as: :login
    delete 'logout' => 'devise/sessions#destroy', as: :logout
  end
  resources :users, only: [] do
    resources :products, only: [:index]
  end

  resources :products, only: [:index, :show] do
    resource :bid, only: [:create, :destroy]
    resources :bids, only: [:index]
    collection do
      get :bidden
    end
  end

  namespace :admin do
    resources :users
    resources :products, only: [:index, :edit, :update, :destroy]
  end

  namespace :seller do
    resources :products, only: [:index, :new, :create, :edit, :update, :destroy] do
      resources :pictures, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
end
