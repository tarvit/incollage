require 'spec_helper'

describe Incollage::ClippingsFinder do

  before :each do
    @search_data = { user_id: 1, collection_id: 1 }
    @finder = Incollage::ClippingsFinder.new(Incollage::UserClippingsCollection.new(1, 1))
    @repo = Incollage::Repository.for_clipping
  end

  it 'should delegate query methods with correct args' do
    [ :find, :find_all, :find_last ].each do |method|
      expect(@repo).to receive(method).with(@search_data)
      @finder.send(method)
    end
  end

  it 'should delegate page queries correctly' do
    expect(@repo).to receive(:find_all_on_page).with(@search_data, 1, 2)
    @finder.find_page(1, 2)
  end

end
