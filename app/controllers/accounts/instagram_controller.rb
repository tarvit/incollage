module Accounts
  class InstagramController < ApplicationController

    def callback
      external_account_id = params[:external_account_id].to_i
      user_id = params[:user_id].to_i

      url = ConnectAccountRouter::InstagramConnectAccountRouter.new(self, external_account_id, user_id).redirect_url

      response = InstagramConnector.new(url).get_response(params[:code])
      external_user_id = response.user.id

      attrs = {
          user_id: user_id,
          external_account_id: external_account_id,
          external_user_id: external_user_id,
          external_meta_info: { access_token: response.access_token }
      }

      Incollage::LinkExternalAccount.new(attrs).execute
      Incollage::SynchronizePrecedingClippings.new
      redirect_to collage_builder_path
    end

  end
end

