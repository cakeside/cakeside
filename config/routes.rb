Cake::Application.routes.draw do

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  root :to => "creations#index"

  # /home
  match "about_us" => "home#about_us"
  match "why_cakeside" => "home#why_cakeside"

  # /creations
  resources :creations do
    resources :photos, :only => [:create, :destroy]
    resources :favorites, :only => [:index, :create]
  end
  match 'creations/crop/:id' => 'creations#crop', :method => 'GET'
  match 'creations/crop_update/:id' => 'creations#crop_update', :as => 'creations_crop_update', :method => 'POST'

  # /profiles
  match "profiles" => "profiles#index", :as => 'profiles', :method => "GET"
  match 'profiles/:id' => 'profiles#show', :as => 'profile', :method => 'GET'
  match 'mine' => 'profiles#mine', :as => 'profiles_mine', :method => 'GET'
  match 'favorites' => 'profiles#favorites', :as => 'profiles_favorites', :method => 'GET'

  # /categories
  match 'categories/:id' => 'categories#show', :method => 'GET'
  get 'categories/show'

  # /search
  get "search/index"

  # /users
  devise_for :users, :controllers => {:registrations => 'registrations'}
  devise_for :user, :path => '', :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register" }
end
