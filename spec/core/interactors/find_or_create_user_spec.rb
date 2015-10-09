require 'spec_helper'

describe Incollage::FindOrCreateUser do


  it 'should find or create a user' do
    expect(Incollage::Repository.for_user.count).to eq(0)

    Incollage::FindOrCreateUser.new({username: 'jd', full_name: 'Johny D'}).execute
    expect(Incollage::Repository.for_user.count).to eq(1)

    Incollage::FindOrCreateUser.new({username: 'jd', full_name: 'Johny D'}).execute
    expect(Incollage::Repository.for_user.count).to eq(1)

    Incollage::FindOrCreateUser.new({username: 'bk', full_name: 'Billy K'}).execute
    expect(Incollage::Repository.for_user.count).to eq(2)
  end

end
