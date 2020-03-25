Rails.application.routes.draw do
  root 'homes#top'
  devise_for :users
  resources :users, only: [:show, :edit, :update]
  resources :boards, except: [:edit, :update]
  resources :comments, only: [:create, :destroy]
end
