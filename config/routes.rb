Rails.application.routes.draw do
  devise_for :users
  get 'messages/index'
  root to: "messages#index"
  resources :users, only: [:edit, :update]
  # 既にルーティングにあるdevise/passwords#editとdevise/password#updateはpassword用。
  # users#editとusers#updateはないので作る必要がある。
  resources :rooms, only: [:new, :create]
end
