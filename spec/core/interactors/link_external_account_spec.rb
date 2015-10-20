require 'spec_helper'

describe Incollage::LinkExternalAccount do

  before :each do
    @user = TestFactories::UserFactory.create
    @account = Incollage::Holder.for_external_accounts.added_accounts.first

    @attrs = { user_id: @user.id, external_account_id: @account.id }
  end

  it 'should link an account' do
    Incollage::LinkExternalAccount.new(@attrs).execute
  end

end
