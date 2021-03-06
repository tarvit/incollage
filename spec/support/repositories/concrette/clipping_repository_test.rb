module ClippingRepositoryTest
  extend ActiveSupport::Concern
  include BaseRepositoryTest

  def new_entity(opts={})
    TestFactories::ClippingFactory.get(opts)
  end

  def search_attrs(user_id, collection_id)
    { user_id: user_id, collection_id: collection_id }
  end

  module ClassMethods

    def test_clipping_repository

      context 'Base' do
        test_base_repository
      end

      context 'Querying' do
        before :each do
          @user_a = 1
          @user_b = 2
          @user_c = 3

          @collection_a = 1
          @collection_b = 2
          @collection_c = 3

          data = [
              { id: 1, external_id: 1, user_id: @user_a, collection_id: @collection_b },
              { id: 2, external_id: 2, user_id: @user_a, collection_id: @collection_a },
              { id: 3, external_id: 3, user_id: @user_b, collection_id: @collection_b },
              { id: 4, external_id: 4, user_id: @user_a, collection_id: @collection_a },
          ]

          data.each do |att|
            @repo.save(new_entity(att))
          end
        end

        it 'should find last clipping of a user within a collection' do
          expect(@repo.count).to eq(4)
          expect(@repo.all.all?(&:valid?)).to be_truthy

          expect(@repo.find_last(search_attrs(@user_a, @collection_a)).id).to eq(4)
          expect(@repo.find_last(search_attrs(@user_a, @collection_b)).id).to eq(1)
          expect(@repo.find_last(search_attrs(@user_b, @collection_b)).id).to eq(3)

          expect(@repo.find_last(search_attrs(@user_c, @collection_a))).to be_nil
          expect(@repo.find_last(search_attrs(@user_b, @collection_a))).to be_nil
          expect(@repo.find_last(search_attrs(@user_a, @collection_c))).to be_nil
        end

        it 'should find first clipping of a user within a collection' do
          expect(@repo.count).to eq(4)

          expect(@repo.find(search_attrs(@user_a, @collection_a)).id).to eq(2)
          expect(@repo.find(search_attrs(@user_a, @collection_b)).id).to eq(1)
          expect(@repo.find(search_attrs(@user_b, @collection_b)).id).to eq(3)

          expect(@repo.find(search_attrs(@user_c, @collection_a))).to be_nil
          expect(@repo.find(search_attrs(@user_b, @collection_a))).to be_nil
          expect(@repo.find(search_attrs(@user_a, @collection_c))).to be_nil
        end

        it 'should find the most recent item' do
          expect(@repo.most_recent(search_attrs(@user_a, @collection_a)).id).to eq(4)
        end

        it 'should find the most preceding item' do
          expect(@repo.most_preceding(search_attrs(@user_a, @collection_a)).id).to eq(2)
        end

        context 'More data' do
          before :each do
            @repo.delete_all

            10.times do |i|
              att = {
                  id: i,
                  user_id: @user_a,
                  collection_id: @collection_a
              }
              @repo.save(new_entity(att))
            end
          end

          it 'should paginate clippings' do
            attrs = search_attrs(@user_a, @collection_a)

            expect(@repo.all.count).to eq(10)

            expect(@repo.find_all_on_page(attrs, 0, 2).map(&:id)).to eq([0, 1])
            expect(@repo.find_all_on_page(attrs, 1, 2).map(&:id)).to eq([2, 3])

            expect(@repo.find_all_on_page(attrs, 0, 5).map(&:id)).to eq([0, 1, 2, 3, 4])
            expect(@repo.find_all_on_page(attrs, 1, 5).map(&:id)).to eq([5, 6, 7, 8, 9])
            expect(@repo.find_all_on_page(attrs, 2, 5).map(&:id)).to eq([])

            expect(@repo.find_all_on_page(attrs, 1, 6).map(&:id)).to eq([6, 7, 8, 9])
            expect(@repo.find_all_on_page(attrs, 0, 100).map(&:id)).to eq([0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
          end
        end
      end

      context 'find for collage' do
        shared_examples 'search by color' do |colors, count, ids|
          let(:options) do
            {user_id: 1, collection_id: 1}
          end

          subject do
            @repo.find_for_collage(options, colors, count).map(&:id)
          end

          before do |example|
            example.with_color_matcher
            Incollage::Repository.register(:clipping, @repo)

            [
                { id: 1, picture: picture( 0.5 => 'ff0000', 0.45 => '00ff00', 0.05 => '0000ff') },
                { id: 2, picture: picture( 0.7 => 'ff0000', 0.2 => '00ff00', 0.1 => '0000ff') },
                { id: 3, picture: picture( 0.9 => 'ff0000', 0.1 => '00ff00', 0.0 => '0000ff') },
            ].each do |att|
              attrs = TestFactories::ClippingFactory.defaults.merge(att)
              TestFactories::ClippingFactory.create(attrs)
            end
          end

          it { is_expected.to eq ids }

          def picture(scores)
            TestFactories::PictureFactory.get(
                histogram: TestFactories::HistogramFactory.get(scores)
            )
          end
        end

        context 'Search red' do
          include_examples 'search by color', %w(ff0000), 1, [3]
        end

        context 'Search green' do
          include_examples 'search by color', %w(00ff00), 1, [1]
        end

        context 'Search blue' do
          include_examples 'search by color', %w(0000ff), 1, [2]
        end

        context 'Search red/green' do
          include_examples 'search by color', %w(ff0000 00ff00), 2, [3, 1]
        end

        context 'Search 3 blue pics' do
          include_examples 'search by color', %w(0000ff), 3, [2, 1, 3]
        end
      end
    end
  end
end
