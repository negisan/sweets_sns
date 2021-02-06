Rails.application.routes.draw do

  namespace :admin do
    get 'users', to: 'user#index'
  end
  get 'weekly_ranking', to: 'weekly_ranking#index'
  get 'all_time_ranking', to: 'all_time_ranking#index'
  resources :posts do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create]
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
