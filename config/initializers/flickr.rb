class FlickrConfig
  class << self
    def app_id
      Rails.application.secrets.flickr_id
    end

    def app_secret
      Rails.application.secrets.flickr_secret
    end
  end
end
