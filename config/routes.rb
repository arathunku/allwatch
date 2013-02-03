AllwatchSite::Application.routes.draw do
  root to: 'static_page#home'
  resources :users do
    resources :looks, only: [:create, :show, :destroy]
  end
  resources :sessions, only: [:new, :create, :destroy]

  match "/signup",     to: "users#new"
  match '/signin',     to: "sessions#new"
  match '/signout',    to: "sessions#destroy", via: :delete
  match '/blog/about', to: "static_page#about"
  match '/users/:id/settings', to: "users#edit"

end
