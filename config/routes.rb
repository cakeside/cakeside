Cake::Application.routes.draw do
  default_url_options(Rails.application.config.action_mailer.default_url_options)

  get "about_us" => "home#about_us"
  get "why_cakeside" => "home#why_cakeside"

  post 'comments', to: 'comments#create'

  resources :tutorials do
    get 'page/:page', :action => :index, :on => :collection
  end
  resources :tutorial_tags, :only => [:index, :show], :path => :tt do
    get ':id/page/:page', :action => :show, :on => :collection
  end

  resources :creations do
    resources :photos, only: [:index, :show]
    resources :favorites, :only => [:index, :create]
    get 'page/:page', :action => :index, :on => :collection
  end
  resources :cakes

  resources :profiles, :only => [:index, :show] do
    get 'page/:page', :action => :index, :on => :collection
  end

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
  devise_for :users, :controllers => {:registrations => 'registrations'}, :path => '', :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register" }

  # sitemap
  get "/sitemap.xml", :to => "sitemap#index", :defaults => {:format => :xml}

  root :to => "creations#index"

  namespace :api, :defaults => { :format => 'json' }  do
    namespace :v1 do
      resources :cakes, :only => [:index, :show] do
        resources :photos, :only => [:index]
      end
      resources :logins, :only => [:create]
    end
  end

  namespace :admin do
    root :to => "users#index"
    resources :users, only: [:index, :show]
    resources :jobs, only: [:index, :show]
    resources :activities, only: [:index]
    resources :subscriptions, only: [:index]
    resources :photos, only: [:index, :show]
    resources :blobs, only: [:index, :show]
    resources :errors, only: [:index, :create]
  end

  namespace :my do
    get 'dashboard', to: 'dashboard#index'
    resources :cakes, only: [:index] do
      resources :photos, only: [:index, :new, :create, :destroy]
    end
    resources :favorites, only: [:index]
    resources :settings, only: [:index, :update]
    resources :passwords, only: [:index, :update]
    resources :avatars, :only => [:edit, :update]
  end
end
