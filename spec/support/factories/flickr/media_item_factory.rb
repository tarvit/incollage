module TestFactories
  module Flickr
    class MediaItemFactory

      class << self

       def get(opts={})
         TarvitHelpers::HashPresenter.present(defaults.merge!(opts))
       end

        def defaults
          {
              id: 4,
              owner: '252525@N55',
              secret: '0001111',
              server: 577,
              farm: 1,
              title: 'images',
              ispublic: 1,
              isfriend: 0,
              isfamily: 0,
              dateupload: 22,
              url_m: 'media_url',
              height_m: 150,
              width_m: 270,
          }
        end
      end
    end
  end
end
