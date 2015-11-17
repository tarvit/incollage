module TestFactories
  module Instagram
    class MediaItemFactory

      class << self

       def get(opts={})
         TarvitHelpers::HashPresenter.present(defaults.merge!(opts))
       end

        def defaults
          {
              id: 4,
              created_time: 5,
              images: { low_resolution: { url: 'media_url' } }
          }
        end
      end
    end
  end
end
