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
      collection_id: 2,
      linked_account_id: 1,
      external_id: 4,
      picture: {
          url: 'media_url',
          external_created_time: 5,
          histogram: { 1 => '00ff00' },
      },
    })
    entity = Incollage::Clipping.new(entity_attrs)
    expect(entity.valid?).to be_truthy
  end

  def fake_media_item
    TarvitHelpers::HashPresenter.present({
        id: 4,
        created_time: 5,
        images: { low_resolution: { url: 'media_url' } }
     })
  end

end
