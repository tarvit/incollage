require 'rails_helper'

describe InstagramAdapter::MediaClipping do

  before :each do
    @collection = Incollage::UserClippingsCollection.new(user_id: 1, collection_id: 2, linked_account_id: 1)
    @media_item = fake_media_item
  end

  it 'should transform response to clipping entity' do
    @media_clipping = InstagramAdapter::MediaClipping.new(@media_item, @collection)
    entity_attrs = @media_clipping.to_entity_attrs
    expect(entity_attrs).to eq({
      user_id: 1,
      external_id: 4,
      external_created_time: 5,
      collection_id: 2,
      linked_account_id: 1,
      picture_url: 'media_url',
      histogram: { 1 => '00ff00' }
    })
  end

  def fake_media_item
    resolution = OpenStruct.new(url: 'media_url')
    images = OpenStruct.new(low_resolution: resolution)
    OpenStruct.new({
        id: 4,
        created_time: 5,
        images: images
     })
  end

end
