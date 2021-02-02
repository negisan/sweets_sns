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
      resource :profile, only: [:show, :edit, :update]
    end
  end

  #resources :users, only: [:show]

  root to: 'home#index'
end
