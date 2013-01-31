AllwatchSite::Application.routes.draw do
  root to: 'static_page#home'
  resources :users

  match "/signup",     to: "users#new"
  match '/blog/about', to: "static_page#about"
end
