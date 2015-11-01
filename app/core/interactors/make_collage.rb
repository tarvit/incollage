module Incollage
  class MakeCollage
    attr_reader :clippings, :user_id

    def initialize(clippings, user_id)
      @clippings = clippings
      @user_id = user_id
    end

    def execute
      Service.for_collage_maker.make(urls)
    end

    protected

    def urls
      clippings.map{|cl| cl.picture.url }
    end

  end
end
