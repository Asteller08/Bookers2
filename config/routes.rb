Rails.application.routes.draw do
  root 'books#top'
  devise_for :users
  get 'home/about' => 'homes#about'
  get 'users/:id' => 'users#show'
  get 'books/:id' => 'books#show'

  resources :books, only: [:top, :edit, :show, :update, :index, :create, :destroy]
  resources :users, only: [:index, :edit, :update, :show]
end