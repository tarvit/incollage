require 'spec_helper'

describe Incollage::FindClippings do

  before :each do
    @user_a = 1
    @user_b = 2
    @user_c = 3

    @collection_a = 1
    @collection_b = 2
    @collection_c = 3

    data = [
        { id: 1, user_id: @user_a, collection_id: @collection_b },
        { id: 2, user_id: @user_a, collection_id: @collection_a },
        { id: 3, user_id: @user_b, collection_id: @collection_b },
        { id: 4, user_id: @user_a, collection_id: @collection_a },
    ].map do |att|
      att.merge!(file_path: 'some_path', histogram: Incollage::Histogram.new(1 => '00ff00'))
    end

    data.each do |att|
      Incollage::AddClipping.new(att).execute
    end
  end

  it 'should find last clipping of a user within a collection' do
    expect(Incollage::Repository.for_clipping.count).to eq(4)

    expect(finder(@user_a, @collection_a).find_last.id).to eq(4)
    expect(finder(@user_a, @collection_b).find_last.id).to eq(1)
    expect(finder(@user_b, @collection_b).find_last.id).to eq(3)

    expect(finder(@user_c, @collection_a).find_last).to be_nil
    expect(finder(@user_b, @collection_a).find_last).to be_nil
    expect(finder(@user_a, @collection_c).find_last).to be_nil
  end

  it 'should find first clipping of a user within a collection' do
    expect(Incollage::Repository.for_clipping.count).to eq(4)

    expect(finder(@user_a, @collection_a).find.id).to eq(2)
    expect(finder(@user_a, @collection_b).find.id).to eq(1)
    expect(finder(@user_b, @collection_b).find.id).to eq(3)

    expect(finder(@user_c, @collection_a).find).to be_nil
    expect(finder(@user_b, @collection_a).find).to be_nil
    expect(finder(@user_a, @collection_c).find).to be_nil
  end

  context 'More data' do

    before :each do
      Incollage::Repository.for_clipping.delete_all

      10.times do |i|
        att = { id: i,
                user_id: @user_a,
                collection_id: @collection_a,
                file_path: 'some_path',
                histogram: Incollage::Histogram.new(1 => '00ff00') }
        Incollage::AddClipping.new(att).execute
      end
    end

    it 'should paginate clippings' do
      finder = finder(@user_a, @collection_a)

      expect(finder.find_all.count).to eq(10)

      expect(finder.find_page(0, 2).map(&:id)).to eq([0, 1])
      expect(finder.find_page(1, 2).map(&:id)).to eq([2, 3])

      expect(finder.find_page(0, 5).map(&:id)).to eq([0, 1, 2, 3, 4])
      expect(finder.find_page(1, 5).map(&:id)).to eq([5, 6, 7, 8, 9])
      expect(finder.find_page(2, 5).map(&:id)).to eq([])

      expect(finder.find_page(1, 6).map(&:id)).to eq([6, 7, 8, 9])
      expect(finder.find_page(0, 100).map(&:id)).to eq([0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
    end

  end

  def finder(user_id, collection_id)
    Incollage::FindClippings.new(Incollage::ClippingsCollection.new(user_id, collection_id, []))
  end

end
