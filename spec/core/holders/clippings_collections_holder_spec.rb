require 'spec_helper'

describe Incollage::ExternalClippingsCollectionsHolder do
  let(:source) { TestSupport::EmptyClippingsSource }
  let(:holder) { Incollage::ExternalClippingsCollectionsHolder.new }
  let(:context) { TestSupport::FakeAbstractService }
  let(:collection_args) {  { id: 15, name: :test, label: 'label', source: source } }
  let(:clippings_collection) { Incollage::ExternalClippingsCollection.new(collection_args) }

  describe 'adding' do
    subject { holder.added_collections.count }

    context 'when empty' do
      it { is_expected.to eq 0 }
    end

    context 'when item added' do
      before { holder.add(collection_args) }

      it { is_expected.to eq 1 }

      context 'when trying to add a duplicated object' do
        subject do
          -> { holder.add(collection_args) }
        end

        it { is_expected.to raise_error(ArgumentError) }
      end

      describe 'get by id' do
        subject { holder.get(clippings_collection.id).id }

        it { is_expected.to eq clippings_collection.id }
      end

      describe 'get by name' do
        subject { holder.get(clippings_collection.name).id }

        it { is_expected.to eq clippings_collection.id }
      end

      describe 'first collection' do
        subject { holder.first_collection.id }

        it { is_expected.to eq clippings_collection.id }
      end
    end
  end
end
