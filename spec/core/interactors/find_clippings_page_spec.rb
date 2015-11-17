require 'spec_helper'

describe Incollage::FindClippingsPage do

  before :each do |example|
    example.with_clipping_repo

    @attrs = {
        user_id: 1,
        collection_id: 2,
        linked_account_id: 3,
        per_page: 4,
        page_number: 5,
    }
  end

  it 'should find a clippings page' do
    fcp = Incollage::FindClippingsPage.new(@attrs)
    expect(Incollage::Repository.for_clipping).to receive(:find_all_on_page)
    fcp.execute
  end

end
