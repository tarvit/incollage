require 'rails_helper'

describe InstagramAdapter::ClippingsSource do

  include BaseSourceTest

  class FakeInstagramClient < TestSupport::FakeAbstractService

    def user_recent_media(*args)
      fake_feed
    end

    def user_media_feed(*args)
      fake_feed
    end

    def user
      OpenStruct.new(id: 10)
    end

    protected

    def fake_feed
      [ TestFactories::Instagram::MediaItemFactory.get ]
    end
  end

  def fake_instagram_client
    FakeInstagramClient.new
  end

  before :each do
    allow(::Instagram).to receive(:client).and_return(fake_instagram_client)
  end

  context 'Received' do
    test_source(InstagramAdapter::ClippingsSource::ReceivedMediaSource.new)
  end

  context 'Posted' do
    test_source(InstagramAdapter::ClippingsSource::PostedMediaSource.new)
  end

end
