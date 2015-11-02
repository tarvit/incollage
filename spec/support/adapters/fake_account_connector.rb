module TestSupport
  class FakeAccountConnector < Incollage::ExternalAccountConnector::Base

    def connect(context, user_id)
      context.redirected(user_id)
    end

    def callback(context, user_id)
      context.linked(user_id)
      {
          external_user_id: "#{user_id}_ext",
          meta_info: {
              access_token: 'perfect_token',
          },
      }
    end

  end
end

