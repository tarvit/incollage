module TestSupport
  class FakeCollageMaker

    def make(urls)
      FakeUploader.new.upload('fake_collage')
    end

  end
end
