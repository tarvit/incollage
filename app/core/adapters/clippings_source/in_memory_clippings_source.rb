module Incollage
  module ClippingsSource
    module InMemory

      class Source

        def recent_clippings(user_clippings_collection, last_clipping)
          next_clippings(user_clippings_collection, last_clipping) do |clipping_data, last_id|
            clipping_data[:external_id] > last_id.try(:external_id).to_i
          end
        end

        def preceding_clippings(user_clippings_collection, last_clipping)
          next_clippings(user_clippings_collection, last_clipping) do |clipping_data, last_id|
            clipping_data[:external_id] < last_id.try(:external_id).to_i
          end
        end

        protected

        def next_clippings(user_clippings_collection, last_clipping, &select_condition)
          clippings = self.class.user_collection(user_clippings_collection.user_id, user_clippings_collection.collection_id)
          clippings.select do |clipping_data|
            select_condition.(clipping_data, last_clipping)
          end
        end

        class << self

          def global_collection
            @gc ||= {}
          end

          def clean
            @gc = {}
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
end
