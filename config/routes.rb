Rails.application.routes.draw do

  resources :companies
  root 'pages#home'

  get 'terms', to: 'pages#terms'
  get 'map', to: 'pages#map'

  resources :jobs
  devise_for :users
end
