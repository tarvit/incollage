require 'spec_helper'

describe Incollage::LinkExternalAccount do

  before :each do
    @user = TestFactories::UserFactory.create
    @account = Incollage::Holder.for_external_accounts.added_accounts.first

    @attrs = TestFactories::LinkedAccountFactory.defaults.merge({
        user_id: @user.id,
        external_account_id: @account.id,
    })
  end

  it 'should link an account' do
    expect(Incollage::Repository.for_linked_account.count).to eq(0)

    Incollage::LinkExternalAccount.new(@attrs).execute

    expect(Incollage::Repository.for_linked_account.count).to eq(1)
  end

end
