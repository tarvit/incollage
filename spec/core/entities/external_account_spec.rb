require 'spec_helper'

describe Incollage::ExternalAccount do

  it 'should raise error if source is invalid' do
    expect(->{
      account = Incollage::ExternalAccount.new(name: 'ex name', label: :label, connector: Object.new, collections: [])
      account.check_validity!
    }).to raise_error(Incollage::Entity::EntityIsInvalidError)

    expect(->{
      account = Incollage::ExternalAccount.new(name: 'ex name', label: :label,
                                               connector: TestSupport::FakeAccountConnector.new(nil), collections: [])
      account.check_validity!
    }).to_not raise_error
  end

end