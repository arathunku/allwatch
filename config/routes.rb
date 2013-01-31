AllwatchSite::Application.routes.draw do
  root to: 'static_page#home'
  match '/blog/about', to: "static_page#about"
end
