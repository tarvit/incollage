require 'spec_helper'

describe Incollage::ExternalAccountsHolder do

  before :each do
    @source = TestSupport::EmptyClippingsSource
    @holder = Incollage::ExternalAccountsHolder.new
    @account_args = {
        id: 4,
        name: :third_party_service,
        label: 'label',
        connector: TestSupport::FakeAccountConnector.new(4),
        collections: [ TestSupport::FakeAbstractService.new ]
    }
    @account = Incollage::ExternalAccount.new(@account_args)
  end

  it 'should add/get clippings collections' do
    expect(@holder.added_accounts.count).to eq(0)

    @holder.add(@account_args)
    expect(@holder.added_accounts.count).to eq(1)

    expect(->{
      @holder.add(@account_args)
    }).to raise_error(ArgumentError)
    expect(@holder.added_accounts.count).to eq(1)

    # querying works
    expect(@holder.get(@account.id).id).to eq(@account.id)
    expect(@holder.get(:third_party_service).id).to eq(@account.id)

    expect(@holder.added_accounts.map &:id).to eq([ @account.id ])
  end

  it 'should be valid' do
    expect(@account.valid?).to be_truthy
    @account.label = nil
    expect(@account.valid?).to be_falsey
  end

end
