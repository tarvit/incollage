module Incollage
  module ClippingSource
    module InMemory

      class Source

        def recent_clippings(collection, last_clipping)
          next_clippings(collection, last_clipping) do |clipping_data, last_id|
            clipping_data[:external_id] > last_id.try(:external_id).to_i
          end
        end

        def preceding_clippings(collection, last_clipping)
          next_clippings(collection, last_clipping) do |clipping_data, last_id|
            clipping_data[:external_id] < last_id.try(:external_id).to_i
          end
        end

        protected

        def next_clippings(collection, last_clipping, &select_condition)
          clippings = self.user_collection(collection.user_id, collection.id)
          clippings.select do |clipping_data|
            select_condition.(clipping_data, last_clipping)
          end
        end

        public

        def global_collection
          @gc ||= {}
        end

        def add_for_user(user_id, collection_id, clippings)
          global_collection[key(user_id, collection_id)] = clippings
        end

        def user_collection(user_id, collection_id)
          global_collection[key(user_id, collection_id)] || []
        end

        private

        def key(user_id, collection_id)
          [ user_id, collection_id ]*?_
        end
      end

    end
  end
end
