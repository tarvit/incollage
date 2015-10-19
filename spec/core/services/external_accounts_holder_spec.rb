require 'spec_helper'

describe Incollage::ExternalAccountsHolder do

  before :each do
    @source = TestSupport::EmptyClippingsSource
    @holder = Incollage::ExternalAccountsHolder.new
    @account_args = [ 4, 'third-party service', [ TestSupport::FakeAbstractService ] ]
    @account = Incollage::ExternalAccount.new(*@account_args)
  end

  it 'should add/get clippings collections' do
    expect(@holder.added_accounts.count).to eq(0)

    @holder.add(*@account_args)
    expect(@holder.added_accounts.count).to eq(1)

    # duplicated adding of the collection with the same ID
    @holder.add(*@account_args)
    expect(@holder.added_accounts.count).to eq(1)

    # querying works
    expect(@holder.get(@account.id).id).to eq(@account.id)
    expect(@holder.added_accounts.map &:id).to eq([ @account.id ])
  end

end
