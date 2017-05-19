Rails.application.routes.draw do
  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  post '/signup',  to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'  
  delete '/logout', to: 'sessions#destroy'
  match 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user

  get '/new_movie', to: 'movies#new'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :users
  resources :movies
#  resources :movies,          only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
