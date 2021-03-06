require 'rails_helper'

describe InstagramAdapter::ClippingsSource do

  include BaseSourceTest

  let(:fake_instagram_client) { TestSupport::FakeInstagramClient.new }

  before do
    allow(::Instagram).to receive(:client).and_return(fake_instagram_client)
  end

  context 'Received' do
    test_source(InstagramAdapter::ClippingsSource::ReceivedMediaSource.new)
  end

  context 'Posted' do
    test_source(InstagramAdapter::ClippingsSource::PostedMediaSource.new)
  end

end
