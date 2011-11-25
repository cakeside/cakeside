Cake::Application.routes.draw do
  root :to => "home#index"

  # /home
  get "home/index"

  # /creations
  resources :creations

  # /profiles
  get "profiles/index"
  get "profiles/show"
  get "profiles/mine"
  match 'profiles/show/:id' => 'profiles#show', :as => 'profile', :method => 'GET'

  # /search
  get "search/index"

  # /artists
  match 'artists' => 'profiles#index', :as => 'all_profiles', :method => 'GET'
  match 'artists/:id' => 'profiles#show', :as => 'profile', :method => 'GET'

  # /categories
  match 'categories/:id' => 'categories#show', :method => 'GET'
  get 'categories/show'

  # /users
  devise_for :users, :controllers => {:registrations => 'registrations'}

end
