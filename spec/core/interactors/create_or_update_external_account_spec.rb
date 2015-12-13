require 'spec_helper'

describe Incollage::LinkExternalAccount::CreateOrUpdateExternalAccount do
  let(:user) { TestFactories::UserFactory.create }
  let(:account) { Incollage::Holder.for_external_accounts.added_accounts.first }
  let(:attrs) do
    values = {
        user_id: user.id,
        external_account_id: account.id,
        external_meta_info: { token: 'token1' }
    }
    TestFactories::LinkedAccountFactory.defaults.merge(values)
  end

  before do |example|
    example.with_user_repo
    example.with_linked_account_repo
    example.with_holders
  end

  describe 'link an account' do
    subject do
      -> {
        described_class.new(attrs).execute
      }
    end

    it 'adds a record' do
      is_expected.to change { Incollage::Repository.for_linked_account.count }.by(1)
    end

    it 'populates token' do
      expect(subject.call.external_meta_info[:token]).to eq('token1')
    end

    it 'does not link twice' do
      expect(subject).to change { Incollage::Repository.for_linked_account.count }.by(1)
      expect(subject).to change { Incollage::Repository.for_linked_account.count }.by(0)
    end
  end
end
