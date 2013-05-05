Cake::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  root :to => "creations#index"

  # /home
  match "about_us" => "home#about_us"
  match "why_cakeside" => "home#why_cakeside"

  resources :tutorials

  # /creations
  resources :creations do
    resources :photos, :only => [:index, :new, :create, :destroy]
    resources :favorites, :only => [:index, :create]
    resources :comments, :only => [:index, :new, :create]
  end

  # /profiles
  resources :profiles, :only => [:index, :show]
  match 'favorites' => 'profiles#favorites', :as => 'profiles_favorites', :method => 'GET'

  # /categories
  resources :categories, :only => [:show]

  # /tags
  resources :tags, :only => [:show]

  # /search
  get "search/index"

  # /users
  devise_for :users, :controllers => {:registrations => 'registrations'}
  devise_for :user, :path => '', :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register" }
  resources :avatars, :only => [:create]

  # sitemap
  match "/sitemap.xml", :to => "sitemap#index", :defaults => {:format => :xml}

  match 'settings/change_password' => 'settings#change_password', :as => 'settings_change_password', :method => 'POST'
end
