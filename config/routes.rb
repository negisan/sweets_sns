Rails.application.routes.draw do

  get 'posts/new'
  get 'posts/show'
  get 'posts/create'
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }

  devise_scope :user do
    get 'sign_in', :to => 'users/sessions#new'
    get 'sign_out', :to => 'users/sessions#destroy'
  end

  get 'home/index'

  root to: 'home#index'
end
