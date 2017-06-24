Rails.application.routes.draw do
  root 'static_pages#welcome'
  get '/home', to: 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  post '/signup',  to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  match 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user
  match 'movies/:id' => 'movies#destroy', :via => :delete, :as => :admin_destroy_movie
  match 'genders/:id' => 'genders#destroy', :via => :delete, :as => :admin_destroy_gender

  get 'visitante', to: 'visitor#action'

  get '/new_movie', to: 'movies#new'
  get '/new_gender', to: 'genders#new'
  
  get '/season', to: 'movie#season'

  get'/filtrar', to: 'functions#filtrar'
  get'/search', to: 'functions#search'

  get '/users/:id/signup_boy', to: 'users#new_boy', :as => :new_boy_creation
  get '/users/:id/boy_accounts', to: 'users#boy_index', :as => :boy_accounts
  post '/users/:id/signup_boy', to: 'users#create_cuenta_niño'

  get '/statistics', to: 'statistics#principal'
  get '/st_generales_path', to: 'statistics#generales'
  get '/st_usuario_path', to: 'statistics#usuario'
  get '/st_graficos_path', to: 'statistics#graficos'

  resources :users do
    member do
      get :following, :followers, :genders
    end
  end
  resources :users
  resources :movies do
    resources :comments, :seasons
  end
  resources :genders
#  resources :movies,          only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
#<!--  <% if current_user.id = movie.user_id %>
#  <span class="name"><%= link_to movie.name, movie, style: 'color:#2E9AFE;' %></span>
#  <% else %>
#  no es igual
#  <span class="name"><%= movie.name %></span>
#  <% end %>-->
