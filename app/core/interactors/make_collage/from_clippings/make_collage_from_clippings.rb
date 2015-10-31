module Incollage
  class MakeCollageFromClippings
    attr_reader :clippings, :user_id

    def initialize(clippings, user_id)
      @clippings = clippings
      @user_id = user_id
    end

    def execute
      MakeCollage.new(files, result_path).execute
    end

    protected

    def result_path
      Service.for_collage_filestorage.safe_collage_path(user_id)
    end

    def files
      @files ||= clippings.map do |img|
        Service.for_collage_filestorage.save_clipping(img.picture_url, img.id).path
      end
    end

  end
end
