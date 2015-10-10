module Incollage
  module ClippingSource
    module InMemory

      class Base

        def next_clippings(collection, last_clipping)
          clippings = self.class.user_collection(collection.user_id, collection.id)
          clippings.select do |clipping_data|
            clipping_data[:id] > last_clipping.try(:id).to_i
          end
        end

        class << self

          def global_collection
            @global_collection ||= {}
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
