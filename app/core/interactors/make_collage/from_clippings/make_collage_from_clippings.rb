module Incollage
  class MakeCollageFromClippings
    attr_reader :clippings, :user_id

    def initialize(clippings, user_id)
      @clippings = clippings
      @user_id = user_id
    end

    def execute
      Gateway.for_collage_maker_factory.get(files, result_path).make
    end

    protected

    def result_path
      Gateway.for_collage_filestorage.safe_collage_path(user_id)
    end

    def files
      clippings.map do |img|
        Gateway.for_collage_filestorage.save_clipping(img.picture_url, img.id).path
      end
    end

  end
end
