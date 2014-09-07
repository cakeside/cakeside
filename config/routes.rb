Cake::Application.routes.draw do
  default_url_options(Rails.application.config.action_mailer.default_url_options)

  get "about_us" => "home#about_us"
  get "why_cakeside" => "home#why_cakeside"

  post 'comments', to: 'comments#create'

  resources :tutorials, only: [:index, :show] do
    get 'page/:page', :action => :index, :on => :collection
  end
  resources :tutorial_tags, :only => [:index, :show], :path => :tt do
    member do
      get 'page/:page', action: :show
    end
  end

  resources :creations, only: [:index, :show], path: :cakes do
    resources :photos, only: [:index, :show]
    resources :favorites, :only => [:index, :create]
    get 'page/:page', :action => :index, :on => :collection, as: :paginate
  end

  get '/creations' => redirect('/cakes')
  get 'creations/:id', to: redirect('/cakes/%{id}')
  get 'creations/page/:page', to: redirect('/cakes/page/%{page}')

  resources :profiles, :only => [:index, :show] do
    get 'page/:page', :action => :index, :on => :collection, as: :paginate
  end

  resources :categories, only: [:show] do
    member do
      get 'page/:page', action: :show, as: :paginate
    end
  end

  # /tags
  resources :creation_tags, :only => [:index, :show], :path => :t do
    member do
      get 'page/:page', action: :show
    end
  end
  get 'tags/:id' => 'creation_tags#show'

  resources :sessions, only: [:new, :create, :destroy]
  get "login" => "sessions#new"
  delete "logout" => "sessions#destroy", id: "me"

  # /search
  get "search" => 'search#index'

  # /users
  devise_for :users, :controllers => {:registrations => 'registrations'}, :path => '', :path_names => { :sign_in => "signin", :sign_out => "signout", :sign_up => "register" }

  # sitemap
  get "/sitemap.xml", to: "sitemap#index", defaults: { format: :xml }

  root to: "creations#index"

  namespace :api, :defaults => { :format => 'json' }  do
    namespace :v1 do
      resources :cakes, only: [:index, :show, :create, :update, :destroy] do
        resources :photos, only: [:index, :show, :create]
      end
      resources :categories, only: [:index]
      resources :tutorials, only: [:index, :create]
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
    resources :sessions, only: [:index, :destroy]
  end

  namespace :my do
    get 'dashboard', to: 'dashboard#index'
    resources :favorites, only: [:index]
    resources :settings, only: [:index, :update]
    resources :passwords, only: [:index, :update]
    resources :avatars, only: [:edit, :update]
    root to: "dashboard#index"
  end
end
