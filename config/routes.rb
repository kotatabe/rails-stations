Rails.application.routes.draw do

  root 'movies#index'
  get '/users/new', to: 'users#new'
  post '/users/new', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :movies do
    resources :schedules do
      resources :sheets
      resources :reservations
    end
  end
  namespace :admin do
    resources :movies, :schedules, :reservations
  end
end
