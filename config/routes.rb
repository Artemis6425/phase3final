Rails.application.routes.draw do
  # ORDER MATTERS 
  resources :users
  resources :games
  resources :runs
  get 'games/:id', to: redirect('games/%{id}/runs') #redirects to below to fix errors
  get 'games/:id/runs', to: 'runs#index', as: "gameindex"
  get '/usersindex', to: 'users#index', as: "userindex"
  get '/users/:id', to: 'users#show', as: "usershow"
  get '/games', to: 'games#index', as: 'gamelist'
  get '/games/:id/runs/new', to: 'runs#new', as: 'newrun'
  get '/games/:id/runs/:id2/edit', to: 'runs#edit', as: 'editrun'


  get '/signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#login'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  post 'logout', to: 'sessions#destroy'
  get '/auth/google_oauth2/callback' => 'sessions#oauthcreate' 





  get '*path', to: redirect('/games') # This redirects *most* broken paths to the default /games, which is the index
end