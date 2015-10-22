class AccountsController < ApplicationController

  def connect
    external_account_id, user_id = params[:external_account_id].to_i, params[:user_id].to_i
    ConnectAccountRouter::Factory.get(self, external_account_id, user_id).execute
  end


end
