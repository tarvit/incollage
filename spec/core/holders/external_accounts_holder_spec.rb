require 'spec_helper'

describe Incollage::ExternalAccountsHolder do
  let(:source) { TestSupport::EmptyClippingsSource }
  let(:holder) { Incollage::ExternalAccountsHolder.new }
  let(:account) { Incollage::ExternalAccount.new(account_args) }
  let(:account_id) { 4 }
  let(:account_args) do
    {
        id: account_id,
        name: :third_party_service,
        label: 'label',
        connector: TestSupport::FakeAccountConnector.new(account_id),
        collections: [ TestSupport::FakeAbstractService.new ]
    }
  end

  describe 'adding' do
    subject { holder.added_accounts.count }

    context 'when empty' do
      it { is_expected.to eq 0 }
    end

    context 'when item added' do
      before { holder.add(account_args) }

      it { is_expected.to eq 1 }

      context 'when trying to add a duplicated object' do
        subject do
          -> { holder.add(account_args) }
        end

        it { is_expected.to raise_error(ArgumentError) }
      end

      describe 'get by id' do
        subject { holder.get(account.id).id }

        it { is_expected.to eq account.id }
      end

      describe 'get by name' do
        subject { holder.get(account.name).id }

        it { is_expected.to eq account.id }
      end
    end
  end

  describe 'validation' do
    subject { account.valid? }

    it { is_expected.to be_truthy }

    context 'when required field is nil' do
      before { account.label = nil }

      it { is_expected.to be_falsey }
    end
  end
end
