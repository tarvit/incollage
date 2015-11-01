module TestSupport
  class FakeUploader

    def upload(file_path)
      next_fake_url
    end

    protected

    def next_fake_url
      "http://fake.com/#{SecureRandom.hex}"
    end

  end
end

