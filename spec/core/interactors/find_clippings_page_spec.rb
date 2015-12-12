require 'spec_helper'

describe Incollage::FindClippingsPage do
  let(:attrs) do
    {
        user_id: 1,
        collection_id: 2,
        linked_account_id: 3,
        per_page: 4,
        page_number: 5,
    }
  end
  let(:instance) { described_class.new(attrs) }

  before do |example|
    example.with_clipping_repo
  end

  it 'should call find_all_on_page in a repo' do
    expect(Incollage::Repository.for_clipping).to receive(:find_all_on_page)
    instance.execute
  end

end
