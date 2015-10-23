module InstagramAdapter
  module ClippingsSource

    class Base

      def recent_clippings(user_clippings_collection, external_id)
        raise NotImplementedError
      end

      def preceding_clippings(user_clippings_collection, external_id)
        raise NotImplementedError
      end

      protected

      def feed(client, options={})
        raise NotImplementedError
      end

      def feed_response(user_clippings_collection, options)
        feed(instagram_client(user_clippings_collection), options).map do |item|
          MediaClipping.new(item, user_clippings_collection).to_entity_attrs
        end
      end

      def instagram_client(user_clippings_collection)
        @client ||= init_instagram_client(user_clippings_collection)
      end

      def init_instagram_client(user_clippings_collection)
        linked_account = Incollage::Repository.for_linked_account.find(id: user_clippings_collection.linked_account_id)
        ::Instagram.client(:access_token => linked_account.external_meta_info[:access_token])
      end

    end
  end
end
