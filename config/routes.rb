Rails.application.routes.draw do
  devise_for :users
  root to: "rooms#index"
  resources :users, only: [:edit, :update]
  # 既にルーティングにあるdevise/passwords#editとdevise/password#updateはpassword用。
  # users#editとusers#updateはないので作る必要がある。
  resources :rooms, only: [:new, :create, :destroy] do 
    resources :messages, onky: [:index, :create]#チャットはあるルームの中でしか書けないため、ネストを利用する。
  end
end
