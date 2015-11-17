require 'rails_helper'

describe FlickrAdapter::MediaClipping do

  before :each do |example|
    example.with_histogram_maker

    @collection = Incollage::UserClippingsCollection.new(user_id: 1, collection_id: 2, linked_account_id: 1)
    @media_item = fake_media_item
  end

  it 'should transform response to clipping entity' do
    @media_clipping = FlickrAdapter::MediaClipping.new(@media_item, @collection)
    entity_attrs = @media_clipping.to_entity_attrs
    expect(entity_attrs).to eq({
      user_id: 1,
      collection_id: 2,
      linked_account_id: 1,
      external_id: 4,
      external_created_time: 22,
      picture: {
          url: 'media_url',
          histogram: { 1 => '00ff00' },
      },
    })
    entity = Incollage::Clipping.new(entity_attrs)
    expect(entity.valid?).to be_truthy
  end

  def fake_media_item
    TarvitHelpers::HashPresenter.present({
        id: 4,
        owner: '252525@N55',
        secret: '0001111',
        server: 577,
        farm: 1,
        title: 'images',
        ispublic: 1,
        isfriend: 0,
        isfamily: 0,
        dateupload: 22,
        url_m: 'media_url',
        height_m: 150,
        width_m: 270,
     })
  end

end
