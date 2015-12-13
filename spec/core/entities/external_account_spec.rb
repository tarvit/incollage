require 'spec_helper'

describe Incollage::ExternalAccount do
  let(:account) do
    Incollage::ExternalAccount.new(name: 'ex name', label: :label, connector: connector, collections: [])
  end

  subject do
    -> { account.validate! }
  end

  describe 'initialization' do
    context 'when connection is an instance of a wrong class' do
      let(:connector) { Object.new }

      it do
        is_expected.to raise_error(Incollage::Validateable::BusinessObjectIsInvalidError)
      end
    end

    context 'when connection is an instance of a correct class' do
      let(:connector) { TestSupport::FakeAccountConnector.new(nil) }

      it do
        is_expected.to_not raise_error
      end
    end
  end
end
