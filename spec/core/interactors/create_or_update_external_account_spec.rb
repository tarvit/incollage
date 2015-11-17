require 'spec_helper'

describe Incollage::LinkExternalAccount::CreateOrUpdateExternalAccount do

  before :each do |example|
    example.with_user_repo
    example.with_linked_account_repo
    example.with_holders

    @user = TestFactories::UserFactory.create
    @account = Incollage::Holder.for_external_accounts.added_accounts.first

    @attrs = TestFactories::LinkedAccountFactory.defaults.merge({
        user_id: @user.id,
        external_account_id: @account.id,
        external_meta_info: { token: 'token1' },
    })
  end

  it 'should link an account' do
    expect(->{
      @linked_account = Incollage::LinkExternalAccount::CreateOrUpdateExternalAccount.new(@attrs).execute
    }).to change{ Incollage::Repository.for_linked_account.count }.by(1)

    expect(@linked_account.external_meta_info[:token]).to eq('token1')

    expect(->{
      attrs = @attrs.merge(external_meta_info: { token: 'token2' })
      @second_linked_account = Incollage::LinkExternalAccount::CreateOrUpdateExternalAccount.new(attrs).execute
    }).to change{ Incollage::Repository.for_linked_account.count }.by(0)

    expect(@second_linked_account.id).to eq(@linked_account.id)
    expect(@second_linked_account.external_meta_info[:token]).to eq('token2')
  end

end
