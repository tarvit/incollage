class ExternalAccountsController < ApplicationController
  before_filter :init_account_id, only: [ :connect, :callback ]
  before_filter :init_connector, only: [ :connect, :callback ]

  def connect
   @connector.connect(self, current_user.id)
  end

  def callback
    @connector.callback(self, current_user.id)
  end

  protected

  def init_account_id
    @external_account_id = params[:external_account_id].to_i
  end

  def init_connector
    @connector = Holder.for_external_accounts.get(@external_account_id).connector
  end

end
