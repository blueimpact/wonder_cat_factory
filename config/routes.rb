Rails.application.routes.draw do
  root 'products#index'

  devise_for :users
  devise_scope :user do
    get 'login' => 'devise/sessions#new', as: :login
    delete 'logout' => 'devise/sessions#destroy', as: :logout
  end

  resources :products, only: [:index, :show] do
    resource :bid, only: [:create, :destroy]
  end

  namespace :admin do
    resources :users
    resources :products, only: [:index, :edit, :update, :destroy]
  end

  namespace :seller do
    resources :products do
      resources :pictures, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
  end
end
