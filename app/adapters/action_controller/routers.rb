module ConnectAccountRouter
  class Base

    attr_reader :controller, :external_account_id, :user_id

    def initialize(controller, external_account_id, user_id)
      @controller = controller
      @user_id = user_id
      @external_account_id = external_account_id
    end

    def connect
      raise NotImplemented
    end
  end

  class InstagramConnectAccountRouter < Base

    def connect
      controller.redirect_to InstagramConnector.new(redirect_url).authorize_url
    end

    def callback
      response = InstagramConnector.new(redirect_url).get_response(controller.params[:code])
      external_user_id = response.user.id

      attrs = {
          user_id: @user_id,
          external_account_id: @external_account_id,
          external_user_id: external_user_id,
          external_meta_info: { access_token: response.access_token }
      }

      Incollage::LinkExternalAccount.new(attrs).execute
      controller.redirect_to controller.collage_builder_path
    end

    protected

    def redirect_url
      controller.external_accounts_callback_url(
          trailing_slash: true,
          external_account_id: external_account_id,
          user_id: user_id
      )
    end
  end

  class Factory
    ROUTERS = {
        instagram_account: InstagramConnectAccountRouter
    }

    def self.get(controller, external_account_id, user_id)
      @external_account = Incollage::Holder.for_external_accounts.get(external_account_id)
      klass = ROUTERS[@external_account.name]
      klass.new(controller, external_account_id, user_id)
    end
  end

end