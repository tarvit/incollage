Rails.application.routes.draw do

  root to: 'root#index'

  namespace :collage do
    get :builder
  end

  namespace :auth do
    get :login
    get :logout
    get :connect
    get :callback
  end
end

