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

  get 'visitante', to: 'visitor#action'

  get '/new_movie', to: 'movies#new'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :users
  resources :movies
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
