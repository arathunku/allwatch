AllwatchSite::Application.routes.draw do
  root to: 'static_page#home'
  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  match "/signup",     to: "users#new"
  match '/signin',     to: "sessions#new"
  match '/signout',    to: "sessions#destroy", via: :delete
  match '/users/:id/settings', to: "users#edit"
  match '/blog/about', to: "static_page#about"

end
