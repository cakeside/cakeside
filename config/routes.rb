Cake::Application.routes.draw do
  resources :creations
  resources :authentications
  resources :categories
  get "home/index"
  get "profiles/index"
  get "profiles/show"
  get "search/index"

  devise_for :users, :controllers => {:registrations => 'registrations'}
  match '/auth/:provider/callback' => 'authentications#create'
  match 'my_creations' => 'creations#mine', :as => 'my_creations', :method => 'GET'
  match 'artists' => 'profiles#index', :as => 'all_profiles', :method => 'GET'
  match 'artists/:id' => 'profiles#show', :as => 'profile', :method => 'GET'
  match 'profiles/show/:id' => 'profiles#show', :as => 'profile', :method => 'GET'
  root :to => "home#index"
end
