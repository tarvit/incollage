module Incollage
  module ClippingSource
    module InMemory

      class Base

        def initialize(user_id, collection_id)
          @user_id, @collection_id = user_id, collection_id
        end

        def next_clippings(last_clipping_id)
          clippings = self.class.user_collection(@user_id, @collection_id)
          clippings.select do |clipping_data|
            clipping_data[:id] > last_clipping_id
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
