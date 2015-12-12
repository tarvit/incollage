require 'spec_helper'

describe Incollage::LinkExternalAccount do
  let(:user) { TestFactories::UserFactory.create(id: 44) }
  let(:context) { TestSupport::FakeAbstractService.new }
  let(:external_account_id) do
    Incollage::Holder.for_external_accounts.added_accounts.first.id
  end

  before do |example|
    example.for_interactor
  end

  context 'Link Account' do

    it 'should connect to an account' do
      expect(context).to receive(:redirected).with(user.id)
      described_class::Connect.new(user.id, external_account_id, context).execute
    end

    it 'should handle callback' do
      expect(context).to receive(:linked).with(user.id)
      described_class::Callback.new(user.id, external_account_id, context).execute
    end
  end
end
