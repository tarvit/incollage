require 'rails_helper'

describe InstagramAdapter::MediaClipping do

  before :each do |example|
    example.with_histogram_maker

    @collection = Incollage::UserClippingsCollection.new(user_id: 1, collection_id: 2, linked_account_id: 1)
    @media_item = TestFactories::Instagram::MediaItemFactory.get
  end

  it 'should transform response to clipping entity' do
    @media_clipping = InstagramAdapter::MediaClipping.new(@media_item, @collection)
    entity_attrs = @media_clipping.to_entity_attrs
    expect(entity_attrs).to eq({
      user_id: 1,
      collection_id: 2,
      linked_account_id: 1,
      external_id: 4,
      external_created_time: 5,
      picture: {
          url: 'media_url',
          histogram: { 1 => '00ff00' },
      },
    })
    entity = Incollage::Clipping.new(entity_attrs)
    expect(entity.valid?).to be_truthy
  end

end
