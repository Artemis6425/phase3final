Rails.application.routes.draw do
  # ORDER MATTERS 
  resources :users
  resources :games do
    resources :runs
  end

  #user index stuff
  get '/usersplaygames', to: 'games#userindex'
  get '/usersindex', to: 'users#index', as: "userindex"

  #login stuff
  get '/signup', to: 'users#new', as: 'signup'
  post '/signup', to: 'users#create', as: 'postsignup'
  get 'login', to: 'users#login'
  post 'login', to: 'users#postlogin', as: 'postlogin'
  get 'logout', to: 'sessions#destroy'
  post 'logout', to: 'sessions#destroy'
  get '/auth/google_oauth2/callback' => 'sessions#oauthcreate' 

  # This redirects *most* broken paths to the default /games, which is the index
  get '*path', to: redirect('/games') 
end
