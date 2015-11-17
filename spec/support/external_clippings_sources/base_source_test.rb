module BaseSourceTest
  extend ActiveSupport::Concern

  module ClassMethods

    def test_source(source)
      before :each do |example|
        example.with_linked_account_repo
        example.with_histogram_maker

        @account = TestFactories::LinkedAccountFactory.create
        @collection = TestFactories::UserClippingsCollectionFactory.get(linked_account_id: @account.id)
        @source = source
      end

      it 'should sync recent' do
        recent = @source.recent_clippings(@collection, nil)
        expect(recent.count).to eq(1)
        expect(recent.first[:picture][:url]).to eq('media_url')
      end

      it 'should sync preceding' do
        recent = @source.preceding_clippings(@collection, nil)
        expect(recent.count).to eq(1)
        expect(recent.first[:picture][:url]).to eq('media_url')
      end
    end
  end
end
