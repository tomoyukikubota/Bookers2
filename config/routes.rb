Rails.application.routes.draw do
  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  devise_for :users
  resources :books, only: [:index, :show, :edit, :create, :update, :destroy]
  resources :users, only: [:index,:show, :edit, :update] do
  resource :favorites, only: [:create, :destroy]
  end
end
