Rails.application.routes.draw do

  root "sessions#index"

  resources :sessions
  resources :registrations
  resources :recipes
  resource :themes, only: :update
end
