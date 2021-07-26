Rails.application.routes.draw do

  root 'pages#home'

  get 'terms', to: 'pages#terms'

  resources :jobs
  devise_for :users
end
