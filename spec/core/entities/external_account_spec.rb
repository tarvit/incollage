require 'spec_helper'

describe Incollage::ExternalAccount do

  it 'should raise error if source is invalid' do
    expect(->{
      account = Incollage::ExternalAccount.new(name: 'ex name', label: :label, connector: Object.new, collections: [])
      account.validate!
    }).to raise_error(Incollage::Validateable::BusinessObjectIsInvalidError)

    expect(->{
      account = Incollage::ExternalAccount.new(name: 'ex name', label: :label,
                                               connector: TestSupport::FakeAccountConnector.new(nil), collections: [])
      account.validate!
    }).to_not raise_error
  end

end
