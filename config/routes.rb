Cake::Application.routes.draw do
  root :to => "home#index"

  # /home
  get "home/index"

  # /creations
  resources :creations
  match 'my_creations' => 'creations#mine', :as => 'my_creations', :method => 'GET'

  # /profiles
  get "profiles/index"
  get "profiles/show"
  match 'profiles/show/:id' => 'profiles#show', :as => 'profile', :method => 'GET'

  # /search
  get "search/index"

  # /artists
  match 'artists' => 'profiles#index', :as => 'all_profiles', :method => 'GET'
  match 'artists/:id' => 'profiles#show', :as => 'profile', :method => 'GET'

  # /categories
  match 'categories/:id' => 'categories#show', :method => 'GET'
  get 'categories/show'

  # /authentications
  match 'authentications' => 'authentications#index', :method => 'GET'
  match '/auth/:provider/callback' => 'authentications#create'

  # /users
  devise_for :users, :controllers => {:registrations => 'registrations'}

end
