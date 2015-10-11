Rails.application.routes.draw do

  root to: 'root#index'

  namespace :collage do
    get :builder
  end

  namespace :clippings do
    get :synchronize_recent
    get :synchronize_preceding
    get :search
  end

  namespace :auth do
    get :login
    get :logout
    get :connect
    get :callback
  end
end

