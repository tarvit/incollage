module FlickrAdapter
  module ClippingsSource
    class GlobalClippingsSource

      def recent_clippings(ucc, recent_clipping)
        clippings_for(ucc, min_upload_date: external_created_time(recent_clipping))
      end

      def preceding_clippings(ucc, preceding_clipping)
        clippings_for(ucc, max_upload_date: external_created_time(preceding_clipping))
      end

      protected

      def external_created_time(clipping)
        clipping.try(:picture).try(:external_created_time)
      end

      def query(ucc, options={})
        account = linked_account(ucc)
        params = { user_id: account.external_user_id, extras: 'date_upload,url_m' }.merge!(options)
        flickr_client.photos.search(params)
      end

      def clippings_for(ucc, options)
        query(ucc, options).map do |item|
          MediaClipping.new(item, ucc).to_entity_attrs
        end
      end

      def flickr_client
        @client ||= Client.get
      end

      def linked_account(ucc)
        @linked_account ||= Incollage::Repository.for_linked_account.find(id: ucc.linked_account_id)
      end
    end
  end
end
