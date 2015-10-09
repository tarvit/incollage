require 'spec_helper'

describe Incollage::FindClippingsPage do

  it 'should find a clippings page' do
    fcp = Incollage::FindClippingsPage.new(1,2,3,4)
    expect(fcp.finder).to receive(:find_page).with(3,4)
    fcp.execute
  end

end
