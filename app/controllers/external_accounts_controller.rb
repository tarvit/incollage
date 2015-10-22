class ExternalAccountsController < ApplicationController
  before_filter :init_ids, only: [ :connect, :callback ]
  before_filter :init_connector, only: [ :connect, :callback ]

  def connect
   @connector.connect(self, @user_id)
  end

  def callback
    @connector.callback(self, @user_id)
  end

  protected

  def init_ids
    @external_account_id, @user_id = params[:external_account_id].to_i, params[:user_id].to_i
  end

  def init_connector
    @connector = Holder.for_external_accounts.get(@external_account_id).connector
  end

end
