class Api::V1::ExternalAccountsController < ApiController
  before_filter :init_account_id, only: [ :connect, :callback ]

  def connect
    Incollage::LinkExternalAccount::Connect.new(current_user.id, @external_account_id, self).execute
  end

  def callback
    Incollage::LinkExternalAccount::Callback.new(current_user.id, @external_account_id, self).execute
  end

  protected

  def init_account_id
    @external_account_id = params[:external_account_id].to_i
  end

end
