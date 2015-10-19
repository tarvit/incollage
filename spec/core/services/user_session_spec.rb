require 'spec_helper'

describe Incollage::UserSession do

  before :each do
    @session = Incollage::UserSession.new({})
    @user = TestFactories::UserFactory.create
  end

  it 'should authenticate user' do
    # in initial state we don't have an authorized user
    expect(@session.authorized?).to be_falsey
    expect(@session.current_user).to be_nil

    @session.certify_user(@user.id)

    # we have the user now
    expect(@session.authorized?).to be_truthy
    expect(@session.current_user.username).to eq(@user.username)

    @session.disallow_current_user

    # session is empty
    expect(@session.authorized?).to be_falsey
    expect(@session.current_user).to be_nil
  end

end
