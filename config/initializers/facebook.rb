class FacebookConfig
  class << self
    def app_id
      Rails.application.secrets.facebook_app_id
    end

    def app_secret
      Rails.application.secrets.facebook_app_secret
    end
  end
end
