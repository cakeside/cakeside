Cake::Application.routes.draw do
  # /home
  match "about_us" => "home#about_us"
  match "why_cakeside" => "home#why_cakeside"

  resources :tutorials do
    get 'page/:page', :action => :index, :on => :collection
  end
  resources :tutorial_tags, :only => [:show], :path => :tt

  # /creations
  resources :creations do
    resources :photos, :only => [:index, :new, :create, :destroy]
    resources :favorites, :only => [:index, :create]
    resources :comments, :only => [:index, :new, :create]
    get 'page/:page', :action => :index, :on => :collection
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
  resources :tags, :only => [:index, :show], :path => :t do
    get 'page/:page', :action => :show
  end
  get 'tags/:id' => 'tags#show'

  # /search
  get "search/index"

  # /users
  devise_for :users, :controllers => {:registrations => 'registrations'}
  devise_for :user, :path => '', :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register" }
  resources :avatars, :only => [:create]

  # sitemap
  match "/sitemap.xml", :to => "sitemap#index", :defaults => {:format => :xml}

  match 'settings/change_password' => 'settings#change_password', :as => 'settings_change_password', :method => 'POST'

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  root :to => "creations#index"

end
