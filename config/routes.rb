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
  match "/signup",     to: "users#new"
  match '/signin',     to: "sessions#new"
  match '/signout',    to: "sessions#destroy", via: :delete
  match '/blog/about', to: "static_page#about"
  match '/users/:id/settings', to: "users#edit"
end
