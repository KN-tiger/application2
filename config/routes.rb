Rails.application.routes.draw do

  get 'messages/create'
  get 'rooms/create'
  get 'rooms/show'
  get 'create/show'
  root to: "homes#top"
  get "home/about" => "homes#about",as: "about"
  get "search" => "searches#search"
  devise_for :users

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  resources :rooms, only: [:create,:show,:index] do
    resources :messages, only: [:create]
  end

end