class Api::V1::ExternalAccountsController < ApiController
  before_filter :init_connector, only: [ :connect, :callback ]

  def connect
   @connector.connect(self, current_user.id)
  end

  def callback
    @connector.callback(self, current_user.id)
  end

  protected

  def init_connector
    external_account_id = params[:external_account_id].to_i
    @connector = Holder.for_external_accounts.get(external_account_id).connector
  end

end
