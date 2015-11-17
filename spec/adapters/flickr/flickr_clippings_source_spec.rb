require 'rails_helper'

describe InstagramAdapter::ClippingsSource do

  include BaseSourceTest

  def fake_flickr_client
    TestSupport::FakeFlickrClient.new
  end

  before :each do
    allow(FlickrAdapter::Client).to receive(:get).and_return(fake_flickr_client)
  end

  test_source(FlickrAdapter::ClippingsSource::GlobalClippingsSource.new)

end
