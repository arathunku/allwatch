AllwatchSite::Application.routes.draw do
  get "users/new"

  root to: 'static_page#home'
  match '/blog/about', to: "static_page#about"
end
