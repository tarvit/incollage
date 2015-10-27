Rails.application.routes.draw do

  root to: 'root#index'

  namespace :auth do
    get :login
    get :sign_up
    get :logout

    post :authenticate
    post :register
  end

  def level_paths
    (1..10).map do |index|
      (1..index).map{|k| ":level#{k}" }.join(?/)
    end
  end

  # Angular States
  namespace :states do
    level_paths.each do |path|
      get path, to: 'root#index'
    end
  end

  namespace :api do
    namespace :v1 do
      resource :stats

      namespace :external_accounts do
        get ':external_account_id/connect', action: :connect, as: :connect
        get :callback, action: :callback, as: :callback
      end

    end
  end



  #-------------

  # namespace :collage do
  #   get :builder
  # end
  #
  # namespace :clippings do
  #   get :synchronize_recent
  #   get :synchronize_preceding
  #   get :search
  # end
  #

  #
  # namespace :external_collections do
  #   get ':external_account_id/:linked_account_id/sync/:external_collection_id', action: :sync, as: :sync
  # end


end

