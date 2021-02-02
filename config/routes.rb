Rails.application.routes.draw do

  resources :posts do
    resources :likes, only: [:create, :destroy]
  end

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }

  devise_scope :user do
    get 'sign_in', :to => 'users/sessions#new'
    get 'sign_out', :to => 'users/sessions#destroy'
  end

  resources :users do
    member do
      get 'profile/show', to: 'users/profile#show'
      get 'profile/edit', to: 'users/profile#edit'
      patch 'profile/update', to: 'users/profile#update'
    end
  end

  root to: 'home#index'
end
