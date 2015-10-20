require 'spec_helper'

describe Incollage::LinkExternalAccount do

  before :each do
    @user = TestFactories::UserFactory.create
    @account = Incollage::Holder.for_external_accounts.added_accounts.first
  end

  it 'should link an account' do
    Incollage::LinkExternalAccount.new(@user.id, @account.id).execute
  end

end
