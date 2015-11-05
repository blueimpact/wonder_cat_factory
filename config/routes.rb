Rails.application.routes.draw do
  root 'products#index'

  devise_for :users
  devise_scope :user do
    get 'login' => 'devise/sessions#new', as: :login
    delete 'logout' => 'devise/sessions#destroy', as: :logout
  end

  resources :products, only: [:index, :show]

  namespace :admin do
    resources :users do
    end
  end

  namespace :seller do
    resources :products do
      resources :pictures, only: [:create, :destroy]
    end
  end
end
