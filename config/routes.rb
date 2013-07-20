Cake::Application.routes.draw do
  # /home
  match "about_us" => "home#about_us"
  match "why_cakeside" => "home#why_cakeside"

  resources :tutorials do
    get 'page/:page', :action => :index, :on => :collection
  end
  resources :tutorial_tags, :only => [:index, :show], :path => :tt do
    get ':id/page/:page', :action => :show, :on => :collection
  end

  # /creations
  resources :creations do
    resources :photos, :only => [:index, :new, :create, :destroy]
    resources :favorites, :only => [:index, :create]
    resources :comments, :only => [:index, :new, :create]
    get 'page/:page', :action => :index, :on => :collection
    get 'mine', :action => :mine, :on => :collection
  end

  # /profiles
  resources :profiles, :only => [:index, :show] do
    get 'page/:page', :action => :index, :on => :collection
  end
  match 'favorites' => 'profiles#favorites', :as => 'profiles_favorites', :method => 'GET'

  # /categories
  get 'categories/:slug' => "categories#show", :as => :category
  get 'categories/:slug/page/:page' => "categories#show"

  # /tags
  resources :creation_tags, :only => [:index, :show], :path => :t do
    get ':id/page/:page', :action => :show, :on => :collection
  end
  get 'tags/:id' => 'creation_tags#show'

  # /search
  get "search" => 'search#index'

  # /users
  devise_for :users, :controllers => {:registrations => 'registrations'}
  devise_for :user, :path => '', :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register" }

  # sitemap
  match "/sitemap.xml", :to => "sitemap#index", :defaults => {:format => :xml}
  match "/comments.xml", :to => "sitemap#comments", :defaults => {:format => :xml}

  resources :settings, :only => [:index, :update]
  resources :passwords, :only => [:index, :update], :path => :pwd
  resources :avatars, :only => [:edit, :update]

  resources :notifications, :only => [:index]

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  root :to => "creations#index"

  namespace :api, :defaults => { :format => 'json' }  do
    namespace :v1 do
      resources :creations, :only => [:index]
      resources :logins, :only => [:create]
    end
  end
end
