Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  resources :users, only: [:show, :edit, :update]
  resources :books, only: [:index, :show, :edit, :create, :update, :destroy]
end
