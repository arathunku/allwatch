AllwatchSite::Application.routes.draw do
  root to: 'static_page#home'
  resources :users, execept: [:show] do
    resources :looks, only: [:show, :create, :destroy] do
      get 'refresh', on: :member
      get 'delete', on: :member
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :admin 
  resources :reset, only: [:index]

  match '/reset/:id/:reset_token', to: "reset#show",  via: :get, as: :reset
  match '/reset', to: "reset#create",  via: :post

  match '/reset/:id/:reset_token', to: "reset#update",  via: :put


  match "/signup",     to: "users#new"
  match '/signin',     to: "sessions#new"
  match '/signout',    to: "sessions#destroy", via: :delete
  match '/blog/about', to: "static_page#about"
  match '/users/:id/settings', to: "users#edit"
end
