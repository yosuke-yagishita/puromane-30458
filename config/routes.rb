Rails.application.routes.draw do
  devise_for :users
  root to: 'projects#index'
  resources :users, only: [:show, :update]
  resources :projects, expect: :index do
    resources :tasks, only: [:create]
  end
end
