Rails.application.routes.draw do

  root "sessions#index"

  resources :sessions
end
