module BaseSourceTest
  extend ActiveSupport::Concern

  module ClassMethods
    def test_source(source)
      let(:account){ TestFactories::LinkedAccountFactory.create }
      let(:collection) do
        TestFactories::UserClippingsCollectionFactory.get(linked_account_id: account.id)
      end

      before :each do |example|
        example.with_linked_account_repo
        example.with_histogram_maker
      end

      it 'should sync recent' do
        recent = source.recent_clippings(collection, nil)
        expect(recent.count).to eq(1)
        expect(recent.first[:picture][:url]).to eq('media_url')
      end

      it 'should sync preceding' do
        preceding = source.preceding_clippings(collection, nil)
        expect(preceding.count).to eq(1)
        expect(preceding.first[:picture][:url]).to eq('media_url')
      end
    end
  end
end
