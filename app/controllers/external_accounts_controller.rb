class ExternalAccountsController < ApplicationController
  before_filter :init_ids, only: [ :connect, :callback ]
  before_filter :init_router, only: [ :connect, :callback ]

  def connect
   @router.connect
  end

  def callback
    @router.callback
  end

  protected

  def init_ids
    @external_account_id, @user_id = params[:external_account_id].to_i, params[:user_id].to_i
  end

  def init_router
    @router = ConnectAccountRouter::Factory.get(self, @external_account_id, @user_id)
  end

end
