Rails.application.routes.draw do
  devise_for :users
  root to: 'projects#index'
  resources :users, only: [:show, :update]
  resources :projects, only: [:new, :create, :show, :edit, :update, :destroy]
end
