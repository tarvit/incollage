require 'spec_helper'

describe Incollage::FindClippingsPage do

  before :each do
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
    expect(fcp.finder).to receive(:find_page).with(5,4)
    fcp.execute
  end

end
