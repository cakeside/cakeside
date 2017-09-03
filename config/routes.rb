Cake::Application.routes.draw do
  default_url_options(Rails.application.config.action_mailer.default_url_options)

  get "about_us" => "home#about_us"
  get "why_cakeside" => "home#why_cakeside"

  resources :tutorials, only: [:index, :show] do
    get 'page/:page', action: :index, on: :collection
  end
  resources :tutorial_tags, only: [:show], path: :tt do
    member do
      get 'page/:page', action: :show
    end
  end

  resources :cakes, only: [:index, :show], path: :cakes do
    resources :favorites, only: [:create]
    get 'page/:page', action: :index, on: :collection, as: :paginate
    collection do
      get :newest, action: 'index', sort: 'newest'
      get :oldest, action: 'index', sort: 'oldest'
    end
  end
  get '/categories/:category', to: 'cakes#index', as: :category
  get '/categories/:category/page/:page', to: 'cakes#index'
  get '/creations' => redirect('/cakes')
  get 'creations/:id', to: redirect('/cakes/%{id}')
  get 'creations/:id/favorites', to: redirect('/cakes/%{id}/favorites')
  get 'creations/page/:page', to: redirect('/cakes/page/%{page}')
  get 't' => 'cakes#index'
  get 't/:tags' => 'cakes#index', as: :creation_tag
  get 't/:tags/page:page' => 'cakes#index'
  get 'tags/:tags' => 'cakes#index'

  resources :products, only: [:index, :show]

  resources :profiles, only: [:index, :show] do
    get 'page/:page', action: :index, on: :collection, as: :paginate
  end


  resources :sessions, only: [:new, :create, :destroy]
  get "login" => "sessions#new"
  delete "logout" => "sessions#destroy", id: "me"

  # /search
  get "search" => 'search#index'

  resources :passwords, only: [:new, :create, :edit, :update]
  resource :registration, only: [:create]

  # sitemap
  get "/sitemap.xml", to: "sitemap#index", defaults: { format: :xml }

  root to: "cakes#index"

  namespace :api, defaults: { :format => 'json' }  do
    namespace :v1 do
      resources :cakes, only: [:index, :show, :create, :update, :destroy] do
        resources :photos, only: [:index, :show, :create]
      end
      resources :categories, only: [:index]
      resources :tutorials, only: [:index, :create]
      resources :profiles, only: [:show, :update]
      resources :logins, only: [:create]
    end
    namespace :v2 do
      resources :cakes, only: [:index, :show]
      resources :photos, only: [:index, :show]
      resources :users, only: [:index, :show]
      resources :categories, only: [:index, :show]
      resources :tutorials, only: [:index, :show]
    end
  end

  namespace :admin do
    root to: "users#index"
    resources :activities, only: [:index]
    resources :errors, only: [:index, :create]
    resources :jobs, only: [:index, :show, :update, :destroy]
    resources :photos, only: [:index, :show, :update]
    resources :products, only: [:index, :show, :create]
    resources :sessions, only: [:index, :destroy]
    resources :users, only: [:index, :show, :update]
  end

  namespace :my do
    get 'dashboard', to: 'dashboard#index'
    resources :favorites, only: [:index]
    resources :settings, only: [:index, :update]
    resources :passwords, only: [:index, :update]
    resources :avatars, only: [:new, :create]
    resource :kitchen, only: [:show]
    root to: "kitchens#show"
  end
end
