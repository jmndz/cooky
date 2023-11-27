Rails.application.routes.draw do

  root "sessions#index"

  resources :sessions
  resources :registrations
  resources :recipes
end
