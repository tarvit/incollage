require 'rails_helper'

describe InstagramMediaClipping do

  before :each do
    @collection = Incollage::ClippingsCollection.new(1, 2)
    @media_item = fake_media_item
  end

  it 'should transform response to clipping entity' do
    @media_clipping = InstagramMediaClipping.new(@media_item, @collection)
    entity_attrs = @media_clipping.to_entity_attrs
    expect(entity_attrs).to eq({
      user_id: 1,
      external_id: 4,
      external_created_time: 5,
      collection_id: 2,
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
