module FlickrAdapter
  class Client
    class << self
      def get(opts={})
        result = new_client
        result.access_token = opts[:access_token] if opts[:access_token]
        result.access_secret = opts[:access_secret] if opts[:access_secret]
        result
      end

      protected

      def new_client
        FlickRaw::Flickr.new
      end
    end
  end
end
