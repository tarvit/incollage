require 'spec_helper'

describe Incollage::LinkExternalAccount do

  before :each do
    @external_account_id = Incollage::Holder.for_external_accounts.added_accounts.first.id
    @user = TestFactories::UserFactory.create(id: 44)
    @context = TestSupport::FakeAbstractService.new
  end

  context 'Link Account' do

    it 'should connect to an account' do
      expect(@context).to receive(:redirected).with(@user.id)
      Incollage::LinkExternalAccount::Connect.new(@user.id, @external_account_id).execute(@context)
    end

    it 'should handle callback' do
      expect(@context).to receive(:linked).with(@user.id)
      Incollage::LinkExternalAccount::Callback.new(@user.id, @external_account_id).execute(@context)
    end

  end
end
