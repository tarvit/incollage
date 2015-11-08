module FlickrAdapter
  class Client

    class << self
      def get(opts={})
        result = new_client
        result.access_token = opts[:oauth_token] if opts[:oauth_token]
        result.access_secret = opts[:oauth_token_secret] if opts[:oauth_token_secret]
        puts opts.inspect
        result
      end

      protected

      def new_client
        FlickRaw::Flickr.new
      end
    end
  end
end
