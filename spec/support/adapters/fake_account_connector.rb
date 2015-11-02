module TestSupport
  class FakeAccountConnector < Incollage::ExternalAccountConnector::Base

    def connect(context, user_id)
      context.redirected(user_id)
    end

    def callback(context, user_id)
      context.linked(user_id)
    end

  end
end

