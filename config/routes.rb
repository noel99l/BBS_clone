Rails.application.routes.draw do
  get 'posts/search'
  root 'homes#top'
  devise_for :users
  resources :users, only: [:show, :edit, :update]
  resources :boards, except: [:edit, :update] do
  	resources :comments, only: [:create, :destroy]
  end
end
