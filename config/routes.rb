Rails.application.routes.draw do

  resources :projects
  resources :companies
  root 'pages#home'

  get 'terms', to: 'pages#terms'
  get 'map', to: 'pages#map'
  get 'admin', to: 'pages#admin'

  resources :jobs do
    member do
      delete "delete_upload/:upload_id", action: :delete_upload, as: :delete_upload
      put "like" => "jobs#like"
    end
  end
  get "my_jobs", to: 'jobs#my_jobs', as: :my_jobs
  get 'tags/:tag', to: 'jobs#index', as: :tag

  devise_for :users
end
