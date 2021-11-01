Rails.application.routes.draw do

  resources :movies do
    resources :schedules do
      resources :sheets
      resources :reservations
    end
  end
  namespace :admin do
    resources :movies, :schedules
  end
end
